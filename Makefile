DOCKER_IMAGE?="sebastienelet/docker-ubuntu1404-ansible"
DOCKER_INIT?=/sbin/init
docker-container-id:=$(shell mktemp)
idempotence:=$(shell mktemp)

test: docker-run docker-test docker-stop

docker-pull:
	docker pull $(DOCKER_IMAGE)

docker-run: docker-pull
	docker run --detach \
	--name="ansible-mongo-backup-test" \
	--volume="${PWD}":/etc/ansible/roles/role_under_test:ro \
	--privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
	$(DOCKER_IMAGE) \
	$(DOCKER_INIT) > $(docker-container-id)

docker-stop:
	docker stop $(shell cat ${docker-container-id})

docker-test: docker-requirements docker-test-syntax docker-test-role docker-test-role-idempotence

docker-requirements:
docker-test-syntax:
	docker exec --tty "$(shell cat ${docker-container-id})" env TERM=xterm ansible-playbook /etc/ansible/roles/role_under_test/tests/test.yml --syntax-check
docker-test-role:
	docker exec "$(shell cat ${docker-container-id})" ansible-playbook /etc/ansible/roles/role_under_test/tests/test.yml -e "$(ROLE_OPTIONS)"
docker-test-role-idempotence:
	docker exec "$(shell cat ${docker-container-id})" ansible-playbook /etc/ansible/roles/role_under_test/tests/test.yml -e "$(ROLE_OPTIONS)" | tee -a $(idempotence)
	tail $(idempotence) \
		| grep -q 'changed=0.*failed=0' \
		&& (echo 'Idempotence test: pass' && exit 0) \
		|| (echo 'Idempotence test: fail' && exit 1)

clean:
	docker rm $(shell docker stop $(shell docker ps -a -q --filter name=ansible-mongo-backup-test --format="{{.ID}}"))

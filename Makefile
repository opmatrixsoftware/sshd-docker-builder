all: newkey gensecret addsshkey deploy

addsshkey:
	kubectl create -f docker-builder-keys.yaml

deploy:
	kubectl create -f sshd-docker-builder.yaml

remove:
	kubectl delete -f sshd-docker-builder.yaml

newkey:
	rm -rf sshkeys
	mkdir sshkeys
	ssh-keygen -q -f sshkeys/id_rsa -N '' -t rsa

gensecret:
	KEY=$$(cat sshkeys/id_rsa.pub |base64 -w 0) ;\
	CONFIG=$$(cat .kube/config |base64 -w 0) ;\
	sed "s/my_key/$${KEY}/" secret.yaml > secret2.yaml ;\
	sed "s/my_config/$${CONFIG}/" secret2.yaml > docker-builder-keys.yaml

.PHONY: newkey gensecret addsshkey deploy remove
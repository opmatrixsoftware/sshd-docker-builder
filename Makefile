all: newkey gensecret addsshkey deploy

addsshkey:
	kubectl create -f ssh-key-secret.yaml

deploy:
	kubectl create -f sshd-docker-builder.yaml

remove:
	kubectl delete -f sshd-docker-builder.yaml

newkey:
	rm -f sshkeys/id_rsa*
	ssh-keygen -q -f sshkeys/id_rsa -N '' -t rsa

gensecret:
	KEY=$$(cat sshkeys/id_rsa.pub | base64) ;\
	sed "s/PUBLIC_KEY/$${KEY}/" secret.yaml > ssh-key-secret.yaml

.PHONY: newkey gensecret addsshkey deploy remove

VERSION = 3

image:
	buildah bud --tag fortune:$(VERSION)

run:
	podman run --name fortune --publish 8080:8080 --rm \
		--env LONG_FORTUNE=$$LONG_FORTUNE localhost/fortune:$(VERSION)

clean:
	-podman stop fortune
	-podman rm fortune
	-podman rmi localhost/fortune:$(VERSION)

registry:
	podman tag localhost/fortune:$(VERSION) quay.io/manue/fortune:$(VERSION)
	podman login quay.io
	podman push quay.io/manue/fortune:$(VERSION)

kube-deploy:
	kubectl apply -f fortune-deployment.yaml

clean-kube:
	kubectl delete deployment/fortune-deploy

helm-install:
	helm install beta ./fortune

helm-uninstall:
	helm uninstall beta

help:
	@echo target availables: image run registry kube-deploy

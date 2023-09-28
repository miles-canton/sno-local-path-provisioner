.PHONY: install uninstall

install:
	git submodule update --init --remote
	sed -i 's/WaitForFirstConsumer/Immediate/g' dependencies/local-path-provisioner/deploy/chart/local-path-provisioner/templates/storageclass.yaml
	@echo # Line break
	helm dependency update
	@echo # Line break
	helm install \
	    --create-namespace \
	    --namespace local-path-storage \
	    local-path-provisioner .

uninstall:
	helm uninstall \
	     --namespace local-path-storage \
	     local-path-provisioner
	oc delete project local-path-storage

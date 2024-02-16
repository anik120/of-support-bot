export EXTERNAL_DATA_STORE_LOCATION   ?= ./data/external

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

fetch-olm-docs: ## Fetch documentation from https://github.com/operator-framework/olm-docs/tree/master
	cd $(EXTERNAL_DATA_STORE_LOCATION) && git clone https://github.com/operator-framework/olm-docs.git && mkdir temp
	mv $(EXTERNAL_DATA_STORE_LOCATION)/olm-docs/content/en/docs/* $(EXTERNAL_DATA_STORE_LOCATION)/temp/
	rm -rf $(EXTERNAL_DATA_STORE_LOCATION)/olm-docs/* 
	rm -rf $(EXTERNAL_DATA_STORE_LOCATION)/olm-docs/.[a-zA-Z]* 
	mv $(EXTERNAL_DATA_STORE_LOCATION)/temp/* $(EXTERNAL_DATA_STORE_LOCATION)/olm-docs/ && rm -rf $(EXTERNAL_DATA_STORE_LOCATION)/temp
	cp ./data/internal/* $(EXTERNAL_DATA_STORE_LOCATION)/olm-docs/
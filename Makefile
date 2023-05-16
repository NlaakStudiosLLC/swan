DBG_MAKEFILE=1
SHELL := /bin/bash
# BuildVersion is uses the target release date from year to day seperated by DOTs (.)
# 2022.12.31
#
# following this is the character `f` which defines the number of Features & fixes seperated by DOT (.)
# f3.14
#
# this states that this release has 3 features and/or breaking changes plus 14 fixes/changes
#
# full example is
# 2022.12.31f3.14
#
# this states that the this version was released on 31st December 2022 and it contains 3 features and 14 fixes/changes
# remember to update the BUILDVERION value below this line before official releases and to set the Commit Hash tag to the same value
BUILDVERSION=2022.12.28f1.0
BUILDDATE=$(date '+%Y.%m.%d')
CHAINNAME=gwfchain
CHAINID=gwfchain
ADDRESSPREFIX=gwf

### DO NOT EDIT BELOW THIS LINE ###
export VERSION=$(BUILDVERSION)
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT_DIR := $(dir $(MKFILE_PATH))

REPOSITORY="$(basename `git rev-parse --show-toplevel`)"
@echo "Auto-Detected repository: $(REPOSITORY)"

.PHONY: serve

create: createChain move createSqrzModule createBlogModule
	$(info ***** $(CHAINNAME) blockchain created *****)

createChain:
	ignite scaffold chain $(CHAINNAME) --address-prefix $(ADDRESSPREFIX)

### Modules
createSqrzModule: createModuleSqrz createMapSqrz createMapSqrzMessages createMapSqrzQueries
	$(info ***** $(CHAINNAME) Sqrz Module created *****)

createModuleSqrz:
	$(info ***** Creating $(CHAINNAME) Sqrz Module *****)	
	ignite scaffold module sqrz --params enabled:bool,costperday:uint,finebase:uint,divisor:uint,finescalarpct:uint --dep account,bank --yes

createBlogModule: createModuleBlog
	$(info ***** $(CHAINNAME) blog Module created *****)

createModuleBlog:
	$(info ***** Creating $(CHAINNAME) blog Module *****)	
	ignite scaffold module blog --params enabled:bool,payperview:int --dep account,bank --yes

### Maps
createMapSqrz	:
	$(info ***** Creating $(CHAINNAME) Sqrz Map *****)
	ignite scaffold map square guid:string tags:array.string image:string hash:string views:int likes:int dislikes:int popularity:int esrb:string --module sqrz --no-message --yes

### Messages

createBlogMessages: createSetBlogState
	$(info ***** Created blog messages for $(CHAINNAME) blockchain *****)

createSetBlogState:
	ignite scaffold message setEnabled enabled:bool --module blog --yes


createMapSqrzMessages: createSetSqrzState createMapSqrzGetByFilter
	$(info ***** Created sqrz messages for $(CHAINNAME) blockchain *****)

createSetSqrzState:
	ignite scaffold message setEnabled enabled:bool --module sqrz --yes
 
createMapSqrzGetByFilter:
	$(info ***** Creating $(CHAINNAME) Sqrz Get By Filter Message *****)
	ignite scaffold message getByFilter square_creator:string square_guid:string square_tags:array.string square_esrb --module sqrz --yes

### Queries
createMapSqrzQueries: createMapSqrzGetByFilterQuery
	$(info ***** Created queries for $(CHAINNAME) blockchain *****)

createMapSqrzGetByFilterQuery:
	$(info ***** Creating $(CHAINNAME) Sqrz Get By Filter Query *****)
	ignite scaffold query SqrzByTags square_creator:string square_guid:string square_tags:array.string square_esrb --module sqrz --yes

### Called Internally ###
move:
	@mv $(PROJECT_DIR)$(CHAINNAME)/app $(PROJECT_DIR)
	@mv $(PROJECT_DIR)$(CHAINNAME)/cmd $(PROJECT_DIR)
	@mv $(PROJECT_DIR)$(CHAINNAME)/docs $(PROJECT_DIR)
	@mv $(PROJECT_DIR)$(CHAINNAME)/proto $(PROJECT_DIR)
	@mv $(PROJECT_DIR)$(CHAINNAME)/testutil $(PROJECT_DIR)
 	@mv $(PROJECT_DIR)$(CHAINNAME)/ts-client $(PROJECT_DIR)
 	@mv $(PROJECT_DIR)$(CHAINNAME)/vue $(PROJECT_DIR)
	@mv $(PROJECT_DIR)$(CHAINNAME)/x $(PROJECT_DIR)
#	@mv $(PROJECT_DIR)$(CHAINNAME)/config.yml $(PROJECT_DIR)
	@mv $(PROJECT_DIR)$(CHAINNAME)/go.mod $(PROJECT_DIR)
	@mv $(PROJECT_DIR)$(CHAINNAME)/go.sum $(PROJECT_DIR)
	@rm -rf $(PROJECT_DIR)$(CHAINNAME)
	$(info ***** $(CHAINNAME) blockchain moved *****)

delete:
	@rm -rf app
	@rm -rf cmd
	@rm -rf docs
	@rm -rf proto
	@rm -rf testutil
	@rm -rf ts-client
	@rm -rf vue
	@rm -rf x
#	@rm -rf config.yml
	@rm -rf go.mod
	@rm -rf go.sum
	@rm -rf $(CHAINNAME)
	$(info ***** $(CHAINNAME) blockchain deleted *****)

serve:
	ignite chain serve
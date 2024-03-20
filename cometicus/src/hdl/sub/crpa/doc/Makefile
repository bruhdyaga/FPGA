####################################################################################
###   Copyright  2015  SRNS.RU Team                                              ###
###      _______. .______     .__   __.      ___ ____.    .______      __    __  ###
###     /       | |   _  \    |  \ |  |     /       |     |   _  \    |  |  |  | ###
###    |   (----` |  |_)  |   |   \|  |    |   (----`     |  |_)  |   |  |  |  | ###
###     \   \     |      /    |  . `  |     \   \         |      /    |  |  |  | ###
### .----)   |    |  |\  \--. |  |\   | .----)   |    __  |  |\  \--. |  `--'  | ###
### |_______/     | _| `.___| |__| \__| |_______/    (__) | _| `.___|  \______/  ###
###                                                                              ###
###   Boldenkov E., Korogodin I.                                                 ###
###                                                                              ###
###   Licensed under the Apache License, Version 2.0 (the "License");            ###
###   you may not use this file except in compliance with the License.           ###
###   You may obtain a copy of the License at                                    ###
###                                                                              ###
###       http://www.apache.org/licenses/LICENSE-2.0                             ###
###                                                                              ###
###   Unless required by applicable law or agreed to in writing, software        ###
###   distributed under the License is distributed on an "AS IS" BASIS,          ###
###   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   ###
###   See the License for the specific language governing permissions and        ###
###   limitations under the License.                                             ###
####################################################################################

include ../personal.conf
include ../Make_common

personal: personal_$(OS)

personal_win: server

personal_linux:
	@ if [ $(SERVER_BUILD_DOCS) -eq 0 ]; then \
	    echo "Local build..."; \
	    make -f MakefileLocal; \
	else \
	    echo "Connection to server..."; \
	    make doserver; \
	fi; \

server:
	@ make doserver

local: 
	@ make -f MakefileLocal

doserver: build_$(OS)

build_win:
	$(SCP_SRNS) -r ../docs ../Make_common ../personal.conf $(USER)@srns.ru:$(PROJECT_DIR)/trunk	
	$(SSH_SRNS) $(USER)@srns.ru -cmd "chmod +x $(PROJECT_DIR)/trunk/docs/tex/CheckAndCp; exit" 
	$(SSH_SRNS) $(USER)@srns.ru -cmd "make -C $(PROJECT_DIR)/trunk/docs -f $(PROJECT_DIR)/trunk/docs/MakefileLocal 1>$(PROJECT_DIR)/trunk/docs/pdf/stdout.txt 2>$(PROJECT_DIR)/trunk/docs/pdf/stderr.txt; exit"
	$(SCP_SRNS) -r $(USER)@srns.ru:$(PROJECT_DIR)/trunk/docs/pdf/* ..\docs\pdf
	type ..\docs\pdf\stderr.txt

build_linux:
	@ export BRANCH_DIR=$(PROJECT_DIR)/`pwd | sed 's/\/docs//g' | sed 's/.*\///g'`; \
	$(SSH_SRNS) $(USER)@srns.ru "if [ ! -d $(PROJECT_DIR) ]; then mkdir $(PROJECT_DIR); fi" ; \
	$(SSH_SRNS) $(USER)@srns.ru "if [ ! -d $$BRANCH_DIR ]; then mkdir $$BRANCH_DIR; fi" ; \
	if [ ! -d ../docs/pdf ]; then mkdir ../docs/pdf; fi ; \
	rsync -rvz -e '$(SSH_SRNS)' ../docs ../Make_common ../personal.conf $(USER)@srns.ru:$$BRANCH_DIR ; \
	$(SSH_SRNS) $(USER)@srns.ru "make -C $$BRANCH_DIR/docs -f $$BRANCH_DIR/docs/MakefileLocal" ; \
	$(SCP_SRNS) $(USER)@srns.ru:$$BRANCH_DIR/docs/pdf/* ../docs/pdf

clean: 
	make -f MakefileLocal clean


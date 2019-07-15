# DMPilot-RuleManager-Docker
The DMPilot-RuleManager software by https://github.com/KNMI/DMPilot-RuleManager, dockerized.

## Run
Modify the ```configuration.py``` file, according to your needs and run the below commands:
* ```docker build -t "rulemanager:1" .```
* ```docker run -dit --name rule_manager rulemanager:1 /bin/bash```
* ```docker exec -it rule_manager /bin/bash```

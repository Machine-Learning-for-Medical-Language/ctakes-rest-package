Instructions for running cTAKES rest server to get CUIs for documents.

0. Install Docker (and make sure it's running correctly)

1. Create a UMLS account: https://uts.nlm.nih.gov/license.html

2. Run the command to create the docker container using the Dockerfile in this directory:
    ```docker build -t ctakes-web-rest .```

3. Create environment variables for your UMLS account:

    ```export ctakes_umlsuser=<your username>```

    ```export ctakes_umlsps=<your pw>```

4. Start the docker container:

    ```./start_rest.sh```

   This will take quite a while to start up. If you get the docker container id with ```docker ps``` you can check the progress of this container startup with ```docker logs <container id>```. You only need to specify the first few characters of the container id. The container is ready when the final line of the log has the following: ```org.apache.catalina.startup.Catalina.start Server startup in [25,329] milliseconds.```

5. Use the functions in ctakes_rest.py to extract CUIs using the REST server. Pseudocode should be soomething like:

```
for (patient_num,discharge_summary) in read_discharge_summaries():
 
```  

where patient_iterator is a generator that uses your APIs for your Word discharge summaries to return patient id, discharge summary tuples.

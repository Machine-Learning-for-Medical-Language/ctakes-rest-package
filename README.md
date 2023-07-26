Instructions for running cTAKES rest server to get CUIs for documents.

0. Install Docker (and make sure it's running correctly)

1. Create a UMLS account: https://uts.nlm.nih.gov/license.html

2. Run the command to create the docker container using the Dockerfile in this directory:

    ```docker build -t ctakes-web-rest .```

3. Create environment variables for your UMLS account:

    ```export ctakes_umlsuser=umls_api_key```

    ```export ctakes_umlspw=<your umls api key>```

4. Start the docker container:

    ```./start_rest.sh```

   This will take quite a while to start up. If you get the docker container id with ```docker ps``` you can check the progress of this container startup with ```docker logs <container id>```. You only need to specify the first few characters of the container id. The container is ready when the final line of the log has the following: ```org.apache.catalina.startup.Catalina.start Server startup in [25,329] milliseconds.```

5. Run the script sample_extract_cuis.py, which demonstrates how to use the functions in ctakes_rest.py to extract CUIs using the REST server. Take a look at output.txt to make sure it ran correctly -- on each line it should print out a filename followed by a space-delimited list of CUIs.

```
python sample_extract_cuis.py fake_notes/ output.txt
 
```  

6. Modify the code in sample_extract_cuis.py to iterate and extract text from your documents. Modify the file writing code so that the first part of each line is some unique identifier for that document/patient.


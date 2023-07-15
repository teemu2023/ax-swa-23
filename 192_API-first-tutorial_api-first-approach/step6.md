

Finally, test the REST service.

Open a new terminal and type in the following command to make a POST request and create a new pet:

curl -X POST -H &#34;Content-Type: application/json&#34; -d &#39;{&#34;name&#34;: &#34;Alex&#34;, &#34;tag&#34;: &#34;Dog&#34;}&#39; http://localhost:8080/pets

After executing the command, there should be a pet stored in the list.
Let&#39;s check this by getting the entire list using the `listPets` method of the REST service.

Open https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/pets in the browser and see if the pet has been saved.





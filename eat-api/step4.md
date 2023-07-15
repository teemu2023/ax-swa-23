# 4.1 supporting services by menu microservice

The Menu microservice support various functions as follows:

/< store_id >/menus: upload a menu in specific store

`curl -X PUT -v http://localhost:5000/c124/menus -H 'authorization: 740becc4b623786cc812c956a5afb30e' -H 'Content-Type: application/json' -d @./menu_service/menu_data.json`{{execute}}


/< store_id >/menus/items: update menu in specific store

`curl -X POST -v http://localhost:5000/c124/menus/items -H 'authorization: 740becc4b623786cc812c956a5afb30e' -H 'Content-Type: application/json' -d @./menu_service/update_menu.json`{{execute}}


/< store_id >/menus: get specific store's menu

`curl -v http://localhost:5000/c124/menus -H 'authorization: 740becc4b623786cc812c956a5afb30e'`{{execute}}

# 4.2 Test case of menu service

The test case of menu service contains four test cases.

1. Upload menu successfully with HTTP response code 200
2. Update menu successfully with HTTP response code 200
3. Get menu successfully with HTTP response code 200
4. Get menu failed (Store's menu not found) with HTTP response code 404

To run the test, we need to install pytest & redis, Execute

`python3 -m pip install pytest`{{execute}}

`python3 -m pip install redis`{{execute}}

After installed the pytest, Execute

`python3 -m pytest -v test_menu_service.py`{{execute}}

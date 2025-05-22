SEFRUIT TUTORIAL BY YUYUZ!!!!
---------------------------------------------------------------------------------------------------------------------------------------------------------
karena setup envnya org" ini beda", jdinya gue gitginore myvenv sama .env. ini step inti lgsg copas aja di terminal :
- python -m venv myvenv 
- myvenv/Scripts/activate 
- cd dlib-install
- python -m pip install dlib-19.24.1-cp311-cp311-win_amd64.whl (py ver 11) / python -m pip install dlib-19.24.99-cp312-cp312-win_amd64.whl (py ver 12)
- cd ..
- pip install -r yuyusrequirement.txt (py 12) / pip install -r yuyusrequirement.txt (+ pip install numpy == 1.25.1)
- buat file .env & paste yg di desc wa
- uvicorn app.main:main_app --reload
---------------------------------------------------------------------------------------------------------------------------------------------------------
biar tau dan ga kaget tiba" duar folder segaban dengan python segaban ygy 

1. Klo ku make environment baru jdinya ga ganggu klo install install lib sama yg ada di device kalian. tpi klo mau caranya di terminal
   - python -m venv myvenv  
   nanti muncul folder baru myvenv. nah cara nyalainnya or aktifinnya itu, 
   - myvenv/Scripts/activate 

2. Install dlib nya soalnya ini error tros klo install dri lib terminal dan ketemu solulunya by install external. ini stepnya, ku masukkin filenya di folder dlib-install biar kelen gampang installnya
   - change directory caranya : cd dlib-install
   - install nya : python -m pip install dlib-19.24.1-cp311-cp311-win_amd64.whl
   - klo mo cek ke install kagak, check versionnya di :  pip show dlib   

3. Install Requirementnya itu isinya library yg dipake
   - pip install -r yuyusrequirement.txt

4. buat file .env trus paste data url yg gue kasih di WhatsApp soalnya gue gitignore. url confi klo API kan

5. run back end : uvicorn app.main:main_app --reload 

6. Folder models :
   - pake sqlalchemy buat ORM ( Object Relational Mapping, a programming technique that facilitates interaction with relational databases by using object-oriented programming languages. ) 
   - models buat create databasenya itu biar mempermudah jdinya mirip migration di PHP

7. Alembic
   - buat revisi or modif table data type database
     1. ganti dri files models.py 
     2. di terminal type >> alembic revision --autogenerate -m "isi ndiri"
     3. >> alembic upgrade head

8. Folder routes :
   - itu buat path functionalnya biar lebih rapih dan ga menumpuk semua di main.py biar gampang nyari juga

9. Folder schemas :
   - Di FastAPI, schemas dipakai untuk Menentukan bentuk data yang boleh masuk (input dari user), menentukan bentuk data yang keluar (ditampilkan ke frontend) jadi kayak template data.
   - data validation by pydantic(built-in nya fast api)

10. Folder utils :
   - helper functionalities nya jadi kek function" dri projectnya yg panjang itu ya masuk ke utils.

11. database.py :
   - path db nya aja

12. main.py :
   - main codenya make Fast API framework and py

13. database : 
   - POSTGRE SQL di NEONDB (serverless database)

14. GMAPS API : 
   - track location user dan maintain dia di range terdekat

anjay berasa developer beut cuy buat readme aowkkwkw mari kita menggila bersama gezzz demi luluz ygy semangat oll terima gaji kalau masih gapaham tanya gpt aja ya karena ini dah mudah dipahami menurut ku yea.



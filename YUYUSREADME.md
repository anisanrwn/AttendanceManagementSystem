SEFRUIT TUTORIAL BY YUYUZ!!!!
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

5. Folder models :
   - pake sqlalchemy buat ORM ( Object Relational Mapping, a programming technique that facilitates interaction with relational databases by using object-oriented programming languages. ) 
   - models buat create databasenya itu biar mempermudah jdinya mirip migration di PHP
   - alembic itu kek fiturnya buat update dkk jdi abis ubah file models.py nya run alembicnya klo mo modif db jdinya ga kek drop table add table tpi modif or update. caranya cek gpt aja biar lebih simple.

5. Folder routes :
   - itu buat path functionalnya biar lebih rapih dan ga menumpuk semua di main.py biar gampang nyari juga

6. Folder schemas :
   - Di FastAPI, schemas dipakai untuk Menentukan bentuk data yang boleh masuk (input dari user), menentukan bentuk data yang keluar (ditampilkan ke frontend) jadi kayak template data.
   - data validation by pydantic(built-in nya fast api)

7. Folder utils :
   - helper functionalities nya jadi kek function" dri projectnya yg panjang itu ya masuk ke utils.

8. database.py :
   - path db nya aja

9. main.py :
   - main codenya make Fast API framework and py

10. database : 
   - POSTGRE SQL di NEONDB (serverless database)

11. GMAPS API : 
   - track location user dan maintain dia di range terdekat

12. CLOUD STORAGE API :
   - store image employee yg buat di encode karena db gabisa save image klo pun bisa itu berat 
   - store image yang bakal auto capture pas face recog jdi nya dia kek proof ajah

anjay berasa developer beut cuy buat readme aowkkwkw mari kita menggila bersama gezzz demi luluz ygy semangat oll terima gaji kalau masih gapaham tanya gpt aja ya karena ini dah mudah dipahami menurut ku yea.
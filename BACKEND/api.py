import os
from flask import Flask, jsonify, request, send_from_directory, abort
from pymongo import MongoClient
from bson.objectid import ObjectId
import json
from flask_cors import CORS
from bson import ObjectId



app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "*"}})


# Connection to Monggo Db

connectionString = 'mongodb+srv://flexerfly:qwerty12345@cluster0.k7vc1vw.mongodb.net/'
# connectionString = 'mongodb://localhost:27017/'
try:
    client = MongoClient(connectionString)

    # Explicitly create/use the "Elib" database
    db_name = "Elib"
    if db_name not in client.list_database_names():
        print(f"Creating database '{db_name}'...")
    db = client[db_name]

    # Define required collections
    required_collections = ["Researches", "TemporaryResearches", "Users"]
    existing_collections = db.list_collection_names()

    for col in required_collections:
        if col not in existing_collections:
            db.create_collection(col)
            print(f"Collection '{col}' created.")

    # Access collections
    collection = db["Researches"]
    temp = db["TemporaryResearches"]
    userCollection = db["Users"]

    # Seed admin user if not already present
    existing_admin = userCollection.find_one({"username": "admin"})
    if not existing_admin:
        admin_user = {
            "_id": ObjectId(),
            "username": "admin",
            "password": "passw0rd",  # Ideally hash this
            "email": "admin@elib.com",
            "role": "admin",
            "studentId": "ADMIN001"
        }
        userCollection.insert_one(admin_user)
        print("Default admin user seeded.")
    else:
        print("Admin user already exists.")

    print("Connected to MongoDB and ensured database and collections.")
except Exception as e:
    print("Error connecting to MongoDB:", e)



UPLOAD_FOLDER = './uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER



@app.route('/api/download/<path:filename>', methods=['GET'])
def download_file(filename):

    try:
        return send_from_directory(app.config['UPLOAD_FOLDER'], filename , as_attachment=True)
    except FileNotFoundError:
        abort(404, description="File not found")



@app.route('/api/getResearchByDep', methods=['GET'])
def get_researchByDep():

    department = request.args.get('dep')
    print(f'Get request {department}')

    # data = list(collection.find({'department': department})) 
    data = list(collection.find({
    'department': department,
    'approvedStatus': 'accepted'
}))
    print(f'{data}')
    

    result = [{
        "id": str(d["_id"]), 
        "college": d["college"], 
               "department": d["department"], 
               "title": d["title"],
               "approvedStatus": d["approvedStatus"],
               "userId": d["userId"],
               "abstract": d["abstract"], 
                "filename": d['filename'],
               "authors": d["authors"], "approvedDate": d["date_approved"],
                 "filepath": d["filepath"], "researchAdvisers": d["researchAdvisers"],
                 "tags": d["tags"]} 
              for d in data]
    
    if result:
        return jsonify(result)
    else:
        return jsonify({"status": "failed"}), 400







@app.route('/api/editStatus', methods=['PATCH'])
def edit_status():
    data = request.get_json()

    research_id = data.get('id')
    status = data.get('status')

    if not research_id or not status:
        return jsonify({'error': 'Missing _id or status'}), 400

    try:
        result = collection.update_one(
            {'_id': ObjectId(research_id)},
            {'$set': {'approvedStatus': status}}
        )

        if result.matched_count == 0:
            return jsonify({'error': 'Research not found'}), 404

        return jsonify({'message': 'Status updated successfully', 'approvedStatus': status}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500





@app.route('/api/getResearchByPendingStatus', methods=['GET'])
def get_researchByPendingStatus():

    data = list(collection.find({'approvedStatus': "pending"})) 
    print(f'{data}')
    

    result = [{
        "id": str(d["_id"]), 
        "college": d["college"], 
               "department": d["department"], 
               "title": d["title"],
               "approvedStatus": d["approvedStatus"],
               "userId": d["userId"],
               "abstract": d["abstract"], 
                "filename": d['filename'],
               "authors": d["authors"], "approvedDate": d["date_approved"],
                 "filepath": d["filepath"], "researchAdvisers": d["researchAdvisers"],
                 "tags": d["tags"]} 
              for d in data]
    
    if result:
        return jsonify(result)
    else:
        return jsonify({"status": "failed"}), 400



@app.route('/api/getResearchByFilter', methods=['GET'])
def get_researchByFilter():

    filter = request.args.get('fil')
    filVal = request.args.get('val')
    print(f'Get request {filter} & {filVal}')

    data = list(collection.find( {filter: filVal.lower(), 'approvedStatus': 'accepted' })) 
    print(f'{data}')
    

    result = [{
        "id": str(d["_id"]), 
        "college": d["college"], 
               "department": d["department"], 
               "title": d["title"], 
               "approvedStatus": d["approvedStatus"],
               "userId": d["userId"],
               "abstract": d["abstract"], 
               "authors": d["authors"], "approvedDate": d["date_approved"],
               "filename": d['filename'],
                 "filepath": d["filepath"], "researchAdvisers": d["researchAdvisers"],
                 "tags": d["tags"]} 
              for d in data]
    


    if result:
        return jsonify(result)
    else:
        return jsonify({"status": "failed"}), 400



@app.route('/api/research', methods=['POST'])
def add_research():
    if 'file' not in request.files:
        return jsonify({"error": "No file part in the request"}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({"error": "No file selected for uploading"}), 400
    dat = request.form.get('dat')
    data = json.loads(dat)
    print(data['college'])


    existing_research = temp.find_one(
        {
            "$or": [
                {"title": data['title'].lower()},
                {"filename": data['filename']},
                {"abstract": data['abstract']}
            ]
        }
    )

    
    print(existing_research)
        

    if existing_research:
        return jsonify({
            "status": "failed",
            'message': 'Title, filename, or abstract already exists. Please enter unique values.'
        }), 200
    
    upload_dir = os.path.join(app.config['UPLOAD_FOLDER'] , data['college'], data['department'] )
    nested_dir = os.path.join(data['college'], data['department'])
    os.makedirs(upload_dir, exist_ok=True)
    file_path = os.path.join(upload_dir, file.filename)
    nested_dir = str(data['college']) + '/' + str(data['department']) + '/' + str(file.filename)
    file.save(file_path)


    document = {
                    'college': data['college'],
                                    'department': data['department'],
                                "title": data['title'].lower(),
                                "userId": data['userId'],
                                "approvedStatus": data['approvedStatus'],
                                "authors":[s.lower() for s in data['authors']],
                                "abstract": data['abstract'],
                                "date_approved": data['approvedDate'][0:10],
                                "filename": data['filename'],
                                "filepath": nested_dir,
                                "researchAdvisers":  [s.lower() for s in data['researhAdvisers']],
                                "tags": [s.lower() for s in data['tags']]
                                }

    
    collection.insert_one(document)
    print(f"Content: {data}")
    print(f"File saved to: {file_path}")

    return jsonify({"status": "success", "filename": file.filename}), 200



@app.route('/api/research', methods=['PATCH'])
def edit_research():
    new_entry = request.get_json()
    if not new_entry:
        return jsonify({"error": "No input data provided"}), 400
    
    document_id = ObjectId(str(new_entry["id"])) 
    print(new_entry)
    
    filter_criteria = {"_id": document_id} 
    update_data = {"$set": new_entry}
    res = collection.update_one(filter_criteria,update_data )

    
    return jsonify({"status": "success"}), 200




@app.route('/api/research', methods=['DELETE'])
def delete_task():
    new_entry = request.get_json()
    if not new_entry:
        return jsonify({"error": "No input data provided"}), 400
    
    document_id = ObjectId(str(new_entry["id"])) 
    print(new_entry)
    filter_criteria = {"_id": document_id} 
    result = collection.delete_one(filter_criteria)
    print(new_entry)

    if result.deleted_count == 1:
        print("Document deleted successfully.")
        return jsonify({"status": "success"}), 200

    else:
        print("Document not found or not deleted.")
        return jsonify({"status": "failed"}), 200











@app.route('/api/register', methods=['POST'])
def register():
    new_entry = request.get_json()
    if not new_entry:
        return jsonify({"error": "No input data provided"}), 400
    


    print(new_entry)

    existing_user = userCollection.find_one(
        {
            "$or": [
                {"username": new_entry['username']},
            ]
        }
    )
    existing_stuID = userCollection.find_one(
        {
            "$or": [
         
         
                {"studentId": new_entry['studentId']},
              
            ]
        }
    )

    existing_email = userCollection.find_one(
        {
            "$or": [
                {"email": new_entry['email']},
            ]
        }
    )
    remarks = []
    if existing_user:
        remarks.append('Username')
    if existing_stuID:
        remarks.append('Student Id')
    if existing_email:
        remarks.append('Email')



    if existing_user or existing_email or existing_stuID:
        return jsonify({
            "status": "failed",
            'message': remarks
        }), 200
    new_entry["_id"] = ObjectId()
    userCollection.insert_one(new_entry)
    return jsonify({"status": "success"}), 200






@app.route('/api/login', methods=['POST'])
def login():
    new_entry = request.get_json()
    if not new_entry:
        return jsonify({"error": "No input data provided"}), 400
    

    print(new_entry)
    user = userCollection.find_one({'username':new_entry['username'], 'password':new_entry['password']})
    print(user)

    if(user == None):
        return jsonify({"status": "failed"}), 200
    else:
        return jsonify({"status": "success", "userId": str(user['_id']), "role": str(user['role']), "userName": str(user['username']) }), 200



    
    



# Run the server on locally and within the Network
if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')

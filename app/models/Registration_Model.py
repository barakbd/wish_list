from system.core.model import Model
from datetime import datetime
import re


class Registration_Model(Model):
    def __init__(self):
        super(Registration_Model, self).__init__()
        self.EMAIL_REGEX = re.compile(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)")
        # http://emailregex.com/
        
    def register_fields_validation(self, form):
        print 'Registration_Model'

        first_name = form['first_name']
        last_name = form['last_name']
        birthday = form['birthday']
        email = form['email']
        password = form['password']
        password_verify = form['password_verify']

        errors = []
        ###################### CHECK FOR EMPTY FIELDS #################################

        required_fields=True
        for value in form.itervalues():
            if not value:
                required_fields=False

        if required_fields==False:
            errors.append('All fields are required')

        ###################### CHECK NAMES #################################

        if not first_name.isalpha() or len(first_name)<3:
            errors.append('First Name - use only alphabet letters, 2 letters minimum')

        if not last_name.isalpha() or len(last_name)<3:
            errors.append('Last Name - use only alphabet letters, 2 letters minimum')
        ###################### CHECK BIRTHDAY #################################


        try:
            datetime.strptime(birthday, '%m/%d/%Y')
            if datetime.strptime(birthday, '%m/%d/%Y') > datetime.today():
                errors.append("Birthday can't be the furture")
        except ValueError:
            # raise ValueError('Incorrect date format')
            errors.append('Enter birthday in format mm/dd/yyyy')

        # if not isinstance(birthday, datetime):
        #     errors.append('Enter birthday in format mm-dd-yyyy')
        # else:
        #     if not datetime.strptime(birthday, '%m/%d/%Y'):
        #         errors.append('Wrong date format. Use mm-dd-yyyy')
        #     elif datetime.strptime(birthday, '%m/%d/%Y') > datetime.today():
        #         errors.append("Can't put date in future")

        ###################### CHECK EMAIL FORMAT #################################
        if not self.EMAIL_REGEX.match(email):
            errors.append('invalid email address')

        ###################### CHECK IF EMAIL EXISTS #################################
        data_email={'email': email}
        query_check_email = 'SELECT email from users where email = :email LIMIT 1'
        query_email_exists = self.db.query_db(query_check_email, data_email)
        if query_email_exists:
            errors.append("Email Exists!")

        ###################### CHECK PASSWORD FIELDS #################################
        if len(password)<8 or password.islower() or password.isdigit() or password.isalpha():
            errors.append('Password must be more than 8 characters, contain 1 uppercase letter and a mixture of numbers and letters')

        if password != password_verify:
            errors.append("passwords don't match")
        print 'Registration Model - Errors are ',errors,'\n'
        if errors:
            return {'status': False, 'errors':errors}

        ###################### IF NO ERRORS CREATE USER #################################
        else:
            pw_hash = self.bcrypt.generate_password_hash(password)
            data_registered = {
                            'first_name':  first_name,
                            'last_name': last_name,
                            'email': email,
                            'pw_hash': pw_hash
                            }
            query_insert_new_user = 'INSERT INTO users (first_name, last_name, email, pw_hash, created_at, updated_at) Values (:first_name, :last_name, :email, :pw_hash, NOW(), NOW())'
            new_user_id = self.db.query_db(query_insert_new_user, data_registered)
            print 'New user id is ', new_user_id,'\n'

            ########## GET NEW USER DETAILS FROM DB #############
            data_new_user = {'new_user_id': new_user_id}
            query_new_user = 'SELECT * from users WHERE user_id = :new_user_id'
            new_user_details = self.db.query_db(query_new_user, data_new_user)
            print 'New user details are ', new_user_details,'\n'
            return {'status': True, 'new_user_details': new_user_details}

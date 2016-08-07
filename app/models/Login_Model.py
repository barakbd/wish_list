from system.core.model import Model
import re

class Login_Model(Model):
    def __init__(self):
        super(Login_Model, self).__init__()
        self.EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9\.\+_-]+@[a-zA-Z0-9\._-]+\.[a-zA-Z]*$')

    def login(self, form):

        errors=[]
        required_fields=True
        for key,value in form.items():
            if not value:
                required_fields=False
                valid=False

        if required_fields==False:
            errors.append('All fields are required')
            print 'empty fields','\n'

        if not self.EMAIL_REGEX.match(form['login_email']):
            errors.append('invalid email address')

        ################## CHECK USER IN DB ######################
        query_login_data = 'SELECT user_id, first_name, last_name, email, pw_hash FROM users WHERE email = :login_email'
        login_data = {
                    'login_email': form['login_email']
                    }
        login_verification = self.db.query_db(query_login_data, login_data)
        print 'Login verification is ',login_verification, '\n'

        if len(login_verification)==0:
            errors.append('No account with this email was found')
            print 'email not found','\n'

        ################## CHECK PASSWORD MATCH ######################
        elif not self.bcrypt.check_password_hash(login_verification[0]['pw_hash'], form['login_password']):
            errors.append('incorrect password')
            print 'incorrect password','\n'

        if errors:
            return {'status': False, 'errors': errors}
        else:
            return{'status': True, 'user_details': login_verification}
            print 'Login success','\n'

    ################## RESET PASSWORD ##################################
    def reset_password_submit(self, form):
        errors=[]
        new_password = form['new_password']

        if not new_password:
            errors.append('Password must be more than 8 characters, contain 1 uppercase letter and a mixture of numbers and letters')
            return {'status': False, 'errors':errors}
        if len(new_password)<8 or new_password.islower() or new_password.isdigit() or new_password.isalpha():
            errors.append('Password must be more than 8 characters, contain 1 uppercase letter and a mixture of numbers and letters')
            return {'status': False, 'errors':errors}
        new_pw_hash = self.bcrypt.generate_password_hash(new_password)
        data_reset_password = {
                            'email': form['login_email'],
                            'new_pw_hash': new_pw_hash
                            }
        query_reset_password = 'UPDATE users SET pw_hash=:new_pw_hash, updated_at=NOW() WHERE email =:email;'

        email_check_query= 'SELECT email FROM users WHERE email=:email;'
        email_check = self.db.query_db(email_check_query, data_reset_password)
        print 'email_check', email_check,'\n'
        if not email_check:
            errors.append('email does not exist')
            return {'status': False, 'errors':errors}
        else:
            new_password_inserted = self.db.query_db(query_reset_password, data_reset_password)
            print 'new_password_inserted', new_password_inserted,'\n'
            return {'status': True}




    ################## VIEW USER ##################################
    def view_user(self, user_id):
        data_view_user = {'user_id': user_id}
        # query_view_user = 'SELECT * FROM quotes LEFT JOIN users on users_user_id=user_id WHERE users_user_id = :user_id;'
        query_view_user = 'SELECT *, (SELECT COUNT(quote_id) FROM quotes WHERE users_user_id = :user_id) AS quote_count FROM quotes LEFT JOIN users on users_user_id=user_id WHERE users_user_id = :user_id;'
        user_quotes = self.db.query_db(query_view_user, data_view_user)
        print 'Users quotes are ', user_quotes, '\n'
        return user_quotes

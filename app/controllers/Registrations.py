from system.core.controller import *
from datetime import datetime

class Registrations(Controller):
    def __init__(self, action):
        super(Registrations, self).__init__(action)
        self.load_model('Registration_Model')
        self.db = self._app.db

    def index(self):
        print 'Home page - session is ',session,'\n'
        # session.clear()
        key_exists=session.get('user_id')
        if key_exists:
            return redirect ('/quotes')
        else:
            return self.load_view('index.html')

    ######################## REGISTER #############################################
    def register(self):
        print 'Registrations: Form info is - ', request.form
        ###################### SESSION FOR TESTING #################################
        session['first_name'] = request.form['first_name']
        session['last_name'] = request.form['last_name']
        session['birthday'] = request.form['birthday']
        session['email'] = request.form['email']
        session['password'] = request.form['password']
        session['password_verify'] = request.form['password_verify']
        ###################### END SESSION FOR TESTING #################################
        create_status = self.models['Registration_Model'].register_fields_validation(request.form)

        if create_status['status'] == False:
            for message in create_status['errors']:
                # print message
                flash(message, 'register_error')
                print 'Flash messages: ',session['_flashes'],'\n'
            return redirect ('/')
        else:
            new_user_details = create_status['new_user_details'][0]
            session['first_name'] = new_user_details['first_name']
            session['last_name'] = new_user_details['last_name']
            session['user_id'] = new_user_details['user_id']
            return redirect('/')

    ######################## LOGOUT #############################################

    def clear_session(self):
        session.clear()
        return redirect('/')

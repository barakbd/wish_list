from system.core.controller import *
from datetime import datetime

class Logins(Controller):
    def __init__(self, action):
        super(Logins, self).__init__(action)
        self.load_model('Login_Model')
        self.db = self._app.db

    def login(self):

        ###################### SESSION FOR TESTING #################################
        session['login_email'] = request.form['login_email']
        session['login_password'] = request.form['login_password']
        ###################### END SESSION FOR TESTING #################################

        login_status = self.models['Login_Model'].login(request.form)
        if login_status['status'] == False:
            for message in login_status['errors']:
                flash(message, 'login_error')
                print 'flash messages: ',session['_flashes'],'\n'
            return redirect ('/')
        else:
            user_details = login_status['user_details'][0]
            print 'User details are ',user_details,'\n'
            session['user_id'] = user_details['user_id']
            session['first_name'] = user_details['first_name']

            return redirect ('/')

    ######################## RESET PASSWORD#############################################
    def reset_password_submit(self):
        session['login_email'] = request.form['login_email']
        session['new_password'] = request.form['new_password']

        reset_password = self.models['Login_Model'].reset_password_submit(request.form)
        if reset_password['status'] == False:
            for error in reset_password['errors']:
                # print message
                flash(error, 'reset_password_error')
                print 'Flash messages: ',session['_flashes'],'\n'
            return redirect ('/')
        else:
            flash('password changed succesfully', 'login_error')
            return redirect('/')

    ######################## SHOW USER PAGE AND QUOTES #############################################

    def view_user(self, user_id):
        print 'Logins - view_user ','\n'
        user_items = self.models['Login_Model'].view_user(user_id)
        return self.load_view('view_user.html', user_items=user_items)

from system.core.controller import *
from datetime import datetime

class Quotes(Controller):
    def __init__(self, action):
        super(Quotes, self).__init__(action)
        self.load_model('Quote_Model')
        self.db = self._app.db

    def index(self):
        print 'Home page - session is ',session,'\n'
        # session.clear()
        key_exists=session.get('user_id')
        if not key_exists:
            return redirect ('/')
        else:
            all_quotes=self.models['Quote_Model'].all_quotes(session)
            print 'Quotes - All quotes are ', all_quotes, '\n'

            fav_quotes=self.models['Quote_Model'].fav_quotes(session)
            print 'Quotes - fav quotes are ', fav_quotes, '\n'

            return self.load_view('quotes.html', all_quotes=all_quotes, fav_quotes=fav_quotes)

    ######################## ADD QUOTE SUBMIT #############################################
    def add_quote_submit(self):
        print 'Quotes - add_quote_submit ','\n'
        print 'Add quote form is', request.form,'\n'
        new_quote=self.models['Quote_Model'].add_quote_submit(request.form, session)
        if new_quote['status'] == False:
            for error in new_quote['errors']:
                flash(error, 'add_quote_error')
                print 'flash messages: ',session['_flashes'],'\n'
            return redirect ('/quotes')
        else:
            quote_add_success_message = request.form['quoted_by'], ' added succesfully!'
            print  quote_add_success_message, '\n'
            flash(quote_add_success_message, 'success')
            return redirect ('/quotes')

    ######################## MARK FAV #############################################
    def mark_fav(self, quote_id):
        print 'Quotes - mark_fav ','\n'
        mark_fav_quote = self.models['Quote_Model'].mark_fav_quote(quote_id, session)
        flash ('Quote added to your list')
        print 'flash messages are ', session['_flashes'], '\n'
        return redirect('/quotes')

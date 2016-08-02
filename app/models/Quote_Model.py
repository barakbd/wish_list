from system.core.model import Model

class Quote_Model(Model):
    def __init__(self):
        super(Quote_Model, self).__init__()

    def all_quotes(self, session):
        data_all_quotes = {'user_id': session['user_id']}
        quoery_all_quotes='SELECT * FROM quotes LEFT JOIN users ON quotes.users_user_id = users.user_id WHERE quotes.quote_id NOT IN (SELECT quotes_quote_id FROM favourites WHERE favourites.users_user_id = :user_id) ORDER BY quotes.created_at DESC;'
        all_quotes = self.db.query_db(quoery_all_quotes, data_all_quotes)
        print 'Quotes_Model - All quotes are ', all_quotes, '\n'
        return all_quotes

    def fav_quotes(self, session):
        data_fav_quotes = {'user_id': session['user_id']}
        query_fav_quotes = 'SELECT * FROM favourites LEFT JOIN quotes ON quotes_quote_id = quote_id LEFT JOIN users ON quotes.users_user_id = users.user_id WHERE favourites.users_user_id = :user_id;'
        fav_quotes = self.db.query_db(query_fav_quotes, data_fav_quotes)
        print 'Quotes_Model - Fav quotes are ', fav_quotes, '\n'
        return fav_quotes

################################### ADD QUOTE SUBMIT ###############################

    def add_quote_submit(self, form, session):
        print 'Quote_Model - add_quote_submit ','\n'
        errors=[]
        if not form['quoted_by'] or not form['quote_text']:
            errors.append('All fields are required')
            print 'Add quote errors -', errors
            return {'status':False, 'errors':errors}


        data_add_quote = {
                    'user_id': session['user_id'],
                    'quoted_by': form['quoted_by'],
                    'quote_text': form['quote_text'],
                    }
        query_insert_quote = 'INSERT INTO quotes (quoted_by, quote_text, users_user_id, created_at, updated_at) VALUES (:quoted_by, :quote_text, :user_id, NOW(), NOW() );'
        quote_id=self.db.query_db(query_insert_quote, data_add_quote)

        return {'status': True, 'quote_id': quote_id}

        ################################### MARK FAV ###############################

    def mark_fav_quote(self, quote_id, session):
        print 'Quote Model - mark_fav_quote method', quote_id , session, '\n'
        data_mark_fav_quote = {
                                'user_id': session['user_id'],
                                'quote_id': quote_id
                                }
        print "data_mark_fav_quote is ", data_mark_fav_quote, '\n'
        query_mark_fav_quote = 'INSERT INTO favourites (quotes_quote_id, users_user_id, created_at) VALUES (:quote_id, :user_id, NOW() )'
        self.db.query_db(query_mark_fav_quote, data_mark_fav_quote)

        ################################### REMOVE FAV ###############################

    def remove_fav_quote(self, quote_id, session):
        print 'Quote Model - remove_fav_quote method', quote_id , session, '\n'
        data_remove_fav_quote = {
                                'user_id': session['user_id'],
                                'quote_id': quote_id
                                }
        print "data_mark_fav_quote is ", data_remove_fav_quote, '\n'
        query_remove_fav_quote = 'DELETE FROM favourites WHERE favourites.users_user_id = :user_id AND quotes_quote_id = :quote_id;'
        self.db.query_db(query_remove_fav_quote, data_remove_fav_quote)

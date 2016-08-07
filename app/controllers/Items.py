from system.core.controller import *
from datetime import datetime

class Items(Controller):
    def __init__(self, action):
        super(Items, self).__init__(action)
        self.load_model('Item_Model')
        self.db = self._app.db

    def index(self):
        print 'Home page - session is ',session,'\n'
        # session.clear()
        key_exists=session.get('user_id')
        if not key_exists:
            return redirect ('/')
        else:
            all_items=self.models['Item_Model'].all_items(session)
            print 'Items - All items are ', all_items, '\n'

            wish_list_items=self.models['Item_Model'].wish_list_items(session)
            print 'Items - wish_list items are ', wish_list_items, '\n'

            return self.load_view('items.html', all_items=all_items, wish_list_items=wish_list_items)

    ######################## ADD ITEM PAGE #############################################
    def add_item_page(self):
        return self.load_view('add_item.html')

    ######################## ADD ITEM SUBMIT #############################################
    def add_item_submit(self):
        print 'Items - add_item_submit ','\n'
        print 'Add item form is', request.form,'\n'
        new_item=self.models['Item_Model'].add_item_submit(request.form, session)
        if new_item['status'] == False:
            for error in new_item['errors']:
                flash(error, 'add_item_error')
                print 'flash messages: ',session['_flashes'],'\n'
            return redirect ('/items/add_item_page')
        else:
            item_add_success_message = request.form['item_name'], ' added succesfully!'
            print  item_add_success_message, '\n'
            flash(item_add_success_message, 'success')
            return redirect ('/items')

    ######################## MARK WISH LIST ITEM #############################################
    def mark_wish_list(self, item_id):
        print 'Items - mark_wish_list ','\n'
        mark_wish_list_item = self.models['Item_Model'].mark_wish_list_item(item_id, session)
        flash ('Item added to your list')
        print 'flash messages are ', session['_flashes'], '\n'
        return redirect('/items')

    ######################## REMOVE WISH LIST ITEM #############################################
    def remove_wish_list(self, item_id):
        print 'Items - remove_wish_list ','\n'
        remove_wish_list_item = self.models['Item_Model'].remove_wish_list_item(item_id, session)
        flash ('Item Removed from your list')
        print 'flash messages are ', session['_flashes'], '\n'
        return redirect('/items')

    ######################## DELETE ITEM #############################################
    def delete_item(self, item_id):
        print 'Items - delete_item ','\n'
        deleted_item = self.models['Item_Model'].delete_item(item_id, session)
        flash('SUccesfully deleted ',deleted_item)
        return redirect ('/items')

    ######################## VIEW ITEM #############################################
    def view_item(self, item_id):
        print 'Items - view_item ','\n'
        users_per_item = self.models['Item_Model'].view_item(item_id)
        return self.load_view('view_item.html', users_per_item = users_per_item)

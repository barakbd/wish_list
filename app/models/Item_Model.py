from system.core.model import Model

class Item_Model(Model):
    def __init__(self):
        super(Item_Model, self).__init__()

    def all_items(self, session):
        data_all_items = {'user_id': session['user_id']}
        quoery_all_items='SELECT * FROM items LEFT JOIN users ON items.users_user_id = users.user_id WHERE items.item_id NOT IN (SELECT items_item_id FROM wish_list WHERE wish_list.users_user_id = :user_id) ORDER BY items.created_at DESC;'
        all_items = self.db.query_db(quoery_all_items, data_all_items)
        print 'Item_Model - All items are ', all_items, '\n'
        return all_items

    def wish_list_items(self, session):
        data_wish_list_items = {'user_id': session['user_id']}
        query_wish_list_items = 'SELECT * FROM wish_list LEFT JOIN items ON items_item_id = item_id LEFT JOIN users ON items.users_user_id = users.user_id WHERE wish_list.users_user_id = :user_id;'
        wish_list_items = self.db.query_db(query_wish_list_items, data_wish_list_items)
        print 'Item_Model - wish list items are ', wish_list_items, '\n'
        return wish_list_items

################################### ADD ITEM SUBMIT ###############################

    def add_item_submit(self, form, session):
        print 'Item_Model - add_item_submit ','\n'
        errors=[]
        if not form['item_name'] or len(form['item_name'])<3:
            errors.append('Please enter item name with a minimum of 3 characters')
            print 'Add item errors -', errors
            return {'status':False, 'errors':errors}


        data_add_item = {
                    'user_id': session['user_id'],
                    'item_name': form['item_name'],
                    }
        query_insert_item = 'INSERT INTO items (item_name, users_user_id, created_at, updated_at) VALUES (:item_name, :user_id, NOW(), NOW() );'
        item_id=self.db.query_db(query_insert_item, data_add_item)
        self.mark_wish_list_item(item_id, session)
        return {'status': True, 'item_id': item_id}

        ################################### MARK WISH LIST ###############################

    def mark_wish_list_item(self, item_id, session):
        print 'Item Model - mark_wish_list_item method', item_id , session, '\n'
        data_mark_wish_list_item = {
                                'user_id': session['user_id'],
                                'item_id': item_id
                                }
        print "data_mark_wish_list_item is ", data_mark_wish_list_item, '\n'
        query_mark_wish_list_item = 'INSERT INTO wish_list (items_item_id, users_user_id, created_at) VALUES (:item_id, :user_id, NOW() )'
        self.db.query_db(query_mark_wish_list_item, data_mark_wish_list_item)

        ################################### REMOVE WISH LIST ###############################

    def remove_wish_list_item(self, item_id, session):
        print 'Item Model - remove_wish_list_item method', item_id , session, '\n'
        data_remove_wish_list_item = {
                                'user_id': session['user_id'],
                                'item_id': item_id
                                }
        print "data_mark_wish_list_item is ", data_remove_wish_list_item, '\n'
        query_remove_wish_list_item = 'DELETE FROM wish_list WHERE wish_list.users_user_id = :user_id AND items_item_id = :item_id;'
        self.db.query_db(query_remove_wish_list_item, data_remove_wish_list_item)

    ################################### DELETE ITEM ###############################
    def delete_item(self, item_id, session):
        print 'Item Model - delete_item method', item_id , session, '\n'
        data_delete_item = {
                                'user_id': session['user_id'],
                                'item_id': item_id
                                }
        print "data_mark_wish_list_item is ", data_delete_item, '\n'
        query_delete_item = 'DELETE FROM items WHERE items.users_user_id = :user_id AND items.item_id = :item_id;'
        self.db.query_db(query_delete_item, data_delete_item)
        return ('success')

    ################################### VIEW ITEM ###############################
    def view_item(self, item_id):
        print 'Item_Model - view_item method', item_id, '\n'
        data_view_item = {
                                'item_id': item_id
                                }
        print "data_mark_wish_list_item is ", data_view_item, '\n'
        query_view_item = 'SELECT * FROM wish_list LEFT JOIN users ON user_id = users_user_id LEFT JOIN items ON item_id = items_item_id WHERE items_item_id = :item_id;'
        users_per_item = self.db.query_db(query_view_item, data_view_item)
        return users_per_item

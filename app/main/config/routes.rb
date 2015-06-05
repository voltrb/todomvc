# See https://github.com/voltrb/volt#routes for more info on routes

client '/active', filter: 'active'
client '/completed', filter: 'completed'

# The main route, this should be last. It will match any params not
# previously matched.
client '/', {}

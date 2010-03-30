# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dojo_online_session',
  :secret      => '9076ebbccc8ffbf02ecfa965d8285a9d8fe33be04e041d8986c1dc834a2d348f56989379804fd25d4a7a27a01d686dfa1abe6d29aafd7cd087ffb97471040ad7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

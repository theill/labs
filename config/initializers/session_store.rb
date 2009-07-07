# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_laboratory_session',
  :secret      => 'ee73975be4d40a9faab3e61940d8fa2dea68c4acffa7bf1ebda00bd15008e037267243111ba47d26339e0d3a7a8d22b32c782e9e9353ab03bde0118678cd308a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

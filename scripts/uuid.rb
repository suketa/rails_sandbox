puts Digest::UUID.uuid_v3(Digest::UUID::DNS_NAMESPACE, 'rubyonrails.org')
puts Digest::UUID.uuid_v4
puts Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, 'rubyonrails.org')

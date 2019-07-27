#!/usr/bin/env ruby

require 'active_support/core_ext'

hash = {
  author: {
    name: 'dave thomas',
    books: [
      { title: 'programming ruby' },
      { title: 'pragramatic programmer' }
    ]
  }
}

transformed_hash = hash.deep_transform_values { |v| v.to_s.titlecase }

pp transformed_hash

hash.deep_transform_values! { |v| v.to_s.titlecase }

pp hash

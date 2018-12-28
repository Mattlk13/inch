require 'inch/language/elixir/provider/reader_v2/docstring'
require 'inch/utils/code_location'

module Inch
  module Language
    module Elixir
      module Provider
        module ReaderV2
          module Object
            # @abstract
            class Base
              # @param hash [Hash] hash returned via JSON interface
              def initialize(hash)
                @hash = hash
              end

              def name
                @hash['name']
              end

              def fullname
                @hash['name']
              end

              def files
                return [] if location.empty?
                file, line_no = location[0], location[1]
                [Inch::Utils::CodeLocation.new('', file, line_no)]
              end

              def filename
                location[0]
              end

              attr_writer :children_fullnames
              def children_fullnames
                @children_fullnames ||= []
              end

              def parent_fullname
                if depth == 1
                  nil
                else
                  fullname.split('.')[0...-1].join('.')
                end
              end

              def api_tag?
                nil
              end

              def aliased_object_fullname
                nil
              end

              def aliases_fullnames
                nil
              end

              def attributes
                []
              end

              def bang_name?
                false
              end

              def constant?
                false # raise NotImplementedError
              end

              def constructor?
                false
              end

              def depth
                fullname.split('.').size
              end

              # @return [Docstring]
              def docstring
                @docstring ||= Docstring.new(original_docstring)
              end

              def getter?
                name =~ /^get_/ # raise NotImplementedError
              end

              def has_children?
                !children_fullnames.empty?
              end

              def has_code_example?
                docstring.code_examples.size > 0
              end

              def has_doc?
                !undocumented?
              end

              def has_multiple_code_examples?
                docstring.code_examples.size > 1
              end

              def has_unconsidered_tags?
                false # raise NotImplementedError
              end

              def method?
                false
              end

              HIDDEN_TYPES = %w(exception impl)
              def nodoc?
                @hash['doc'] == false ||
                  HIDDEN_TYPES.include?(@hash['type'])
              end

              def namespace?
                false
              end

              def original_docstring
                @hash['doc']
              end

              def overridden?
                false # raise NotImplementedError
              end

              def overridden_method_fullname
                nil # raise NotImplementedError
              end

              def parameters
                []
              end

              def private?
                false
              end

              def tagged_as_internal_api?
                false
              end

              def tagged_as_private?
                nodoc?
              end

              def protected?
                false
              end

              def public?
                true
              end

              def questioning_name?
                fullname =~ /\?$/
              end

              def return_described?
                false # raise NotImplementedError
              end

              def return_mentioned?
                false # raise NotImplementedError
              end

              def return_typed?
                false # raise NotImplementedError
              end

              def in_root?
                depth == 1
              end

              def setter?
                name =~ /^set_/ # raise NotImplementedError
              end

              def source
                nil
              end

              def unconsidered_tag_count
                0
              end

              def undocumented?
                original_docstring.nil? || original_docstring.to_s.strip.empty?
              end

              def visibility
                :public
              end

              private

              def location
                @hash['location'].to_s.split(':')
              end

            end
          end
        end
      end
    end
  end
end

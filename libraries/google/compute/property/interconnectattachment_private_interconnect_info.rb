# Copyright 2018 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

module Google
  module Compute
    module Data
      # A class to manage data for PrivateInterconnectInfo for interconnect_attachment.
      class InterconnectAttachmentPrivateInterconnectInfo
        include Comparable

        attr_reader :tag8021q

        def to_json(_arg = nil)
          {
            'tag8021q' => tag8021q
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            tag8021q: tag8021q.to_s
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? InterconnectAttachmentPrivateInterconnectInfo
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? InterconnectAttachmentPrivateInterconnectInfo
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            result = compare[:self] <=> compare[:other]
            return result unless result.zero?
          end
          0
        end

        def inspect
          to_json
        end

        private

        def compare_fields(other)
          [
            { self: tag8021q, other: other.tag8021q }
          ]
        end
      end

      # Manages a InterconnectAttachmentPrivateInterconnectInfo nested object
      # Data is coming from the GCP API
      class InterconnectAttachmentPrivateInterconnectInfoApi < InterconnectAttachmentPrivateInterconnectInfo
        def initialize(args)
          @tag8021q = Google::Compute::Property::Integer.api_parse(args['tag8021q'])
        end
      end

      # Manages a InterconnectAttachmentPrivateInterconnectInfo nested object
      # Data is coming from the Chef catalog
      class InterconnectAttachmentPrivateInterconnectInfoCatalog < InterconnectAttachmentPrivateInterconnectInfo
        def initialize(args)
          @tag8021q = Google::Compute::Property::Integer.catalog_parse(args[:tag8021q])
        end
      end
    end

    module Property
      # A class to manage input to PrivateInterconnectInfo for interconnect_attachment.
      class InterconnectAttachmentPrivateInterconnectInfo
        def self.coerce
          lambda do |x|
            type = ::Google::Compute::Property::InterconnectAttachmentPrivateInterconnectInfo
            type.catalog_parse(x)
          end
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return value if value.is_a? Data::InterconnectAttachmentPrivateInterconnectInfo
          Data::InterconnectAttachmentPrivateInterconnectInfoCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return value if value.is_a? Data::InterconnectAttachmentPrivateInterconnectInfo
          Data::InterconnectAttachmentPrivateInterconnectInfoApi.new(value)
        end
      end
    end
  end
end
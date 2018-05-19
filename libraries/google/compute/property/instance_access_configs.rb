# Copyright 2017 Google Inc.
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

require 'google/compute/property/array'
module Google
  module Compute
    module Data
      # A class to manage data for access_configs for instance.
      class InstancAccessConfigs
        include Comparable

        attr_reader :name
        attr_reader :nat_ip
        attr_reader :type
        attr_reader :network_tier

        def to_json(_arg = nil)
          {
            'name' => name,
            'natIP' => nat_ip,
            'type' => type,
            'networkTier' => network_tier
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            name: name.to_s,
            nat_ip: nat_ip.to_s,
            type: type.to_s,
            network_tier: network_tier.to_s
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? InstancAccessConfigs
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? InstancAccessConfigs
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
            { self: name, other: other.name },
            { self: nat_ip, other: other.nat_ip },
            { self: type, other: other.type },
            { self: network_tier, other: other.network_tier }
          ]
        end
      end

      # Manages a InstancAccessConfigs nested object
      # Data is coming from the GCP API
      class InstancAccessConfigsApi < InstancAccessConfigs
        def initialize(args)
          @name = Google::Compute::Property::String.api_parse(args['name'])
          @nat_ip = Google::Compute::Property::AddressAddressRef.api_parse(
            args['natIP']
          )
          @type = Google::Compute::Property::Enum.api_parse(args['type'])
          @network_tier =
            Google::Compute::Property::Enum.api_parse(args['networkTier'])
        end
      end

      # Manages a InstancAccessConfigs nested object
      # Data is coming from the Chef catalog
      class InstancAccessConfigsCatalog < InstancAccessConfigs
        def initialize(args)
          @name = Google::Compute::Property::String.catalog_parse(args[:name])
          @nat_ip = Google::Compute::Property::AddressAddressRef.catalog_parse(
            args[:nat_ip]
          )
          @type = Google::Compute::Property::Enum.catalog_parse(args[:type])
          @network_tier =
            Google::Compute::Property::Enum.catalog_parse(args[:network_tier])
        end
      end
    end

    module Property
      # A class to manage input to access_configs for instance.
      class InstancAccessConfigs
        def self.coerce
          lambda do |x|
            ::Google::Compute::Property::InstancAccessConfigs.catalog_parse(x)
          end
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return value if value.is_a? Data::InstancAccessConfigs
          Data::InstancAccessConfigsCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return value if value.is_a? Data::InstancAccessConfigs
          Data::InstancAccessConfigsApi.new(value)
        end
      end

      # A Chef property that holds an integer
      class InstancAccessConfigsArray < Google::Compute::Property::Array
        def self.coerce
          lambda do |x|
            type = ::Google::Compute::Property::InstancAccessConfigsArray
            type.catalog_parse(x)
          end
        end

        # Used for parsing Chef catalog
        def self.catalog_parse(value)
          return if value.nil?
          return InstancAccessConfigs.catalog_parse(value) \
            unless value.is_a?(::Array)
          value.map { |v| InstancAccessConfigs.catalog_parse(v) }
        end

        # Used for parsing GCP API responses
        def self.api_parse(value)
          return if value.nil?
          return InstancAccessConfigs.api_parse(value) \
            unless value.is_a?(::Array)
          value.map { |v| InstancAccessConfigs.api_parse(v) }
        end
      end
    end
  end
end

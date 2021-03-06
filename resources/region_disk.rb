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

# Add our google/ lib
$LOAD_PATH.unshift ::File.expand_path('../libraries', ::File.dirname(__FILE__))

require 'chef/resource'
require 'google/compute/network/delete'
require 'google/compute/network/get'
require 'google/compute/network/post'
require 'google/compute/network/put'
require 'google/compute/property/instance_selflink'
require 'google/compute/property/integer'
require 'google/compute/property/namevalues'
require 'google/compute/property/region_name'
require 'google/compute/property/regiondisk_disk_encryption_key'
require 'google/compute/property/regiondisk_source_snapshot_encryption_key'
require 'google/compute/property/regiondisktype_selflink'
require 'google/compute/property/snapshot_selflink'
require 'google/compute/property/string'
require 'google/compute/property/string_array'
require 'google/compute/property/time'
require 'google/compute/property/zone_selflink'
require 'google/hash_utils'

module Google
  module GCOMPUTE
    # A provider to manage Google Compute Engine resources.
    class RegionDisk < Chef::Resource
      resource_name :gcompute_region_disk

      property :label_fingerprint,
               [String, ::Google::Compute::Property::String],
               coerce: ::Google::Compute::Property::String.coerce, desired_state: true
      property :creation_timestamp,
               Time, coerce: ::Google::Compute::Property::Time.coerce, desired_state: true
      property :description,
               String, coerce: ::Google::Compute::Property::String.coerce, desired_state: true
      property :id,
               Integer, coerce: ::Google::Compute::Property::Integer.coerce, desired_state: true
      property :last_attach_timestamp,
               Time, coerce: ::Google::Compute::Property::Time.coerce, desired_state: true
      property :last_detach_timestamp,
               Time, coerce: ::Google::Compute::Property::Time.coerce, desired_state: true
      property :labels,
               [Hash, ::Google::Compute::Property::NameValues],
               coerce: ::Google::Compute::Property::NameValues.coerce, desired_state: true
      # licenses is Array of Google::Compute::Property::StringArray
      property :licenses,
               Array, coerce: ::Google::Compute::Property::StringArray.coerce, desired_state: true
      property :rd_label,
               String,
               coerce: ::Google::Compute::Property::String.coerce,
               name_property: true, desired_state: true
      property :size_gb,
               Integer, coerce: ::Google::Compute::Property::Integer.coerce, desired_state: true
      # users is Array of Google::Compute::Property::InstanceSelfLinkRefArray
      property :users,
               Array,
               coerce: ::Google::Compute::Property::InstanceSelfLinkRefArray.coerce,
               desired_state: true
      # replica_zones is Array of Google::Compute::Property::ZoneSelfLinkRefArray
      property :replica_zones,
               Array,
               coerce: ::Google::Compute::Property::ZoneSelfLinkRefArray.coerce, desired_state: true
      property :type,
               [String, ::Google::Compute::Data::RegionDiskTypeSelfLinkRef],
               coerce: ::Google::Compute::Property::RegionDiskTypeSelfLinkRef.coerce,
               desired_state: true
      property :region,
               [String, ::Google::Compute::Data::RegionNameRef],
               coerce: ::Google::Compute::Property::RegionNameRef.coerce, desired_state: true
      property :disk_encryption_key,
               [Hash, ::Google::Compute::Data::RegionDiskDiskEncryptionKey],
               coerce: ::Google::Compute::Property::RegionDiskDiskEncryptionKey.coerce,
               desired_state: true
      property :source_snapshot,
               [String, ::Google::Compute::Data::SnapshotSelfLinkRef],
               coerce: ::Google::Compute::Property::SnapshotSelfLinkRef.coerce, desired_state: true
      property :source_snapshot_encryption_key,
               [Hash, ::Google::Compute::Data::RegionDiskSourceSnapshotEncryptionKey],
               coerce: ::Google::Compute::Property::RegionDiskSourceSnapshotEncryptionKey.coerce,
               desired_state: true
      property :source_snapshot_id,
               String, coerce: ::Google::Compute::Property::String.coerce, desired_state: true

      property :credential, String, desired_state: false, required: true
      property :project, String, desired_state: false, required: true

      # TODO(alexstephen): Check w/ Chef how to not expose this property yet
      # allow the resource to store the @fetched API results for exports usage.
      property :__fetched, Hash, desired_state: false, required: false

      action :create do
        fetch = fetch_resource(@new_resource, self_link(@new_resource), 'compute#disk')
        if fetch.nil?
          converge_by "Creating gcompute_region_disk[#{new_resource.name}]" do
            # TODO(nelsonjr): Show a list of variables to create
            # TODO(nelsonjr): Determine how to print green like update converge
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            create_req = ::Google::Compute::Network::Post.new(
              collection(@new_resource), fetch_auth(@new_resource),
              'application/json', resource_to_request
            )
            @new_resource.__fetched =
              wait_for_operation create_req.send, @new_resource
          end
        else
          @current_resource = @new_resource.clone
          @current_resource.label_fingerprint =
            ::Google::Compute::Property::String.api_parse(fetch['labelFingerprint'])
          @current_resource.creation_timestamp =
            ::Google::Compute::Property::Time.api_parse(fetch['creationTimestamp'])
          @current_resource.description =
            ::Google::Compute::Property::String.api_parse(fetch['description'])
          @current_resource.id = ::Google::Compute::Property::Integer.api_parse(fetch['id'])
          @current_resource.last_attach_timestamp =
            ::Google::Compute::Property::Time.api_parse(fetch['lastAttachTimestamp'])
          @current_resource.last_detach_timestamp =
            ::Google::Compute::Property::Time.api_parse(fetch['lastDetachTimestamp'])
          @current_resource.labels =
            ::Google::Compute::Property::NameValues.api_parse(fetch['labels'])
          @current_resource.licenses =
            ::Google::Compute::Property::StringArray.api_parse(fetch['licenses'])
          @current_resource.size_gb =
            ::Google::Compute::Property::Integer.api_parse(fetch['sizeGb'])
          @current_resource.users =
            ::Google::Compute::Property::InstanceSelfLinkRefArray.api_parse(fetch['users'])
          @current_resource.replica_zones =
            ::Google::Compute::Property::ZoneSelfLinkRefArray.api_parse(fetch['replicaZones'])
          @current_resource.type =
            ::Google::Compute::Property::RegionDiskTypeSelfLinkRef.api_parse(fetch['type'])
          @new_resource.__fetched = fetch

          update
        end
      end

      action :delete do
        fetch = fetch_resource(@new_resource, self_link(@new_resource), 'compute#disk')
        unless fetch.nil?
          converge_by "Deleting gcompute_region_disk[#{new_resource.name}]" do
            delete_req = ::Google::Compute::Network::Delete.new(
              self_link(@new_resource), fetch_auth(@new_resource)
            )
            wait_for_operation delete_req.send, @new_resource
          end
        end
      end

      # TODO(nelsonjr): Add actions :manage and :modify

      def exports
        {
          name: rd_label,
          self_link: __fetched['selfLink']
        }
      end

      private

      action_class do
        def resource_to_request
          request = {
            kind: 'compute#disk',
            description: new_resource.description,
            labels: new_resource.labels,
            licenses: new_resource.licenses,
            name: new_resource.rd_label,
            sizeGb: new_resource.size_gb,
            replicaZones: new_resource.replica_zones,
            type: new_resource.type,
            diskEncryptionKey: new_resource.disk_encryption_key,
            sourceSnapshotEncryptionKey: new_resource.source_snapshot_encryption_key
          }.reject { |_, v| v.nil? }
          request.to_json
        end

        def update
          converge_if_changed do |_vars|
            # TODO(nelsonjr): Determine how to print indented like upd converge
            # TODO(nelsonjr): Check w/ Chef... can we print this in red?
            puts # making a newline until we find a better way TODO: find!
            compute_changes.each { |log| puts "    - #{log.strip}\n" }
            if (@current_resource.labels != @new_resource.labels)
              label_fingerprint_update(@current_resource)
            end
            if (@current_resource.size_gb != @new_resource.size_gb)
              size_gb_update(@current_resource)
            end
            return fetch_resource(@new_resource, self_link(@new_resource),
                                  'compute#disk')
          end
        end

        def self.fetch_export(resource, type, id, property)
          return if id.nil?
          resource.resources("#{type}[#{id}]").exports[property]
        end

        def self.resource_to_hash(resource)
          {
            project: resource.project,
            name: resource.rd_label,
            kind: 'compute#disk',
            label_fingerprint: resource.label_fingerprint,
            creation_timestamp: resource.creation_timestamp,
            description: resource.description,
            id: resource.id,
            last_attach_timestamp: resource.last_attach_timestamp,
            last_detach_timestamp: resource.last_detach_timestamp,
            labels: resource.labels,
            licenses: resource.licenses,
            size_gb: resource.size_gb,
            users: resource.users,
            replica_zones: resource.replica_zones,
            type: resource.type,
            region: resource.region,
            disk_encryption_key: resource.disk_encryption_key,
            source_snapshot: resource.source_snapshot,
            source_snapshot_encryption_key: resource.source_snapshot_encryption_key,
            source_snapshot_id: resource.source_snapshot_id
          }.reject { |_, v| v.nil? }
        end

  def label_fingerprint_update(data)
    ::Google::Compute::Network::Post.new(
      URI.join(
        'https://www.googleapis.com/compute/v1/',
        expand_variables(
          'projects/{{project}}/regions/{{region}}/disks/{{name}}/setLabels',
          data
        )
      ),
      fetch_auth(@new_resource),
      'application/json',
      {
        labelFingerprint: @new_resource.__fetched['labelFingerprint'],
        labels: @new_resource.labels
      }.to_json
    ).send
  end

  def size_gb_update(data)
    ::Google::Compute::Network::Post.new(
      URI.join(
        'https://www.googleapis.com/compute/v1/',
        expand_variables(
          'projects/{{project}}/regions/{{region}}/disks/{{name}}/resize',
          data
        )
      ),
      fetch_auth(@new_resource),
      'application/json',
      {
        sizeGb: @new_resource.size_gb
      }.to_json
    ).send
  end
        # Copied from Chef > Provider > #converge_if_changed
        def compute_changes
          properties = @new_resource.class.state_properties.map(&:name)
          properties = properties.map(&:to_sym)
          if current_resource
            compute_changes_for_existing_resource properties
          else
            compute_changes_for_new_resource properties
          end
        end

        # Collect the list of modified properties
        def compute_changes_for_existing_resource(properties)
          specified_properties = properties.select do |property|
            @new_resource.property_is_set?(property)
          end
          modified = specified_properties.reject do |p|
            @new_resource.send(p) == current_resource.send(p)
          end

          generate_pretty_green_text(modified)
        end

        def generate_pretty_green_text(modified)
          property_size = modified.map(&:size).max
          modified.map! do |p|
            properties_str = if @new_resource.sensitive
                               '(suppressed sensitive property)'
                             else
                               [
                                 @new_resource.send(p).inspect,
                                 "(was #{current_resource.send(p).inspect})"
                               ].join(' ')
                             end
            "  set #{p.to_s.ljust(property_size)} to #{properties_str}"
          end
        end

        # Write down any properties we are setting.
        def compute_changes_for_new_resource(properties)
          property_size = properties.map(&:size).max
          properties.map do |property|
            default = ' (default value)' \
              unless @new_resource.property_is_set?(property)
            next if @new_resource.send(property).nil?
            properties_str = if @new_resource.sensitive
                               '(suppressed sensitive property)'
                             else
                               @new_resource.send(property).inspect
                             end
            ["  set #{property.to_s.ljust(property_size)}",
             "to #{properties_str}#{default}"].join(' ')
          end.compact
        end

        def fetch_auth(resource)
          self.class.fetch_auth(resource)
        end

        def self.fetch_auth(resource)
          resource.resources("gauth_credential[#{resource.credential}]")
                  .authorization
        end

        def fetch_resource(resource, self_link, kind)
          self.class.fetch_resource(resource, self_link, kind)
        end

        def debug(message)
          Chef::Log.debug(message)
        end

        def self.collection(data)
          URI.join(
            'https://www.googleapis.com/compute/v1/',
            expand_variables(
              'projects/{{project}}/regions/{{region}}/disks',
              data
            )
          )
        end

        def collection(data)
          self.class.collection(data)
        end

        def self.self_link(data)
          URI.join(
            'https://www.googleapis.com/compute/v1/',
            expand_variables(
              'projects/{{project}}/regions/{{region}}/disks/{{name}}',
              data
            )
          )
        end

        def self_link(data)
          self.class.self_link(data)
        end

        # rubocop:disable Metrics/CyclomaticComplexity
        def self.return_if_object(response, kind, allow_not_found = false)
          raise "Bad response: #{response.body}" \
            if response.is_a?(Net::HTTPBadRequest)
          raise "Bad response: #{response}" \
            unless response.is_a?(Net::HTTPResponse)
          return if response.is_a?(Net::HTTPNotFound) && allow_not_found 
          return if response.is_a?(Net::HTTPNoContent)
          result = JSON.parse(response.body)
          raise_if_errors result, %w[error errors], 'message'
          raise "Bad response: #{response}" unless response.is_a?(Net::HTTPOK)
          result
        end
        # rubocop:enable Metrics/CyclomaticComplexity

        def return_if_object(response, kind, allow_not_found = false)
          self.class.return_if_object(response, kind, allow_not_found)
        end

        def self.extract_variables(template)
          template.scan(/{{[^}]*}}/).map { |v| v.gsub(/{{([^}]*)}}/, '\1') }
                  .map(&:to_sym)
        end

        def self.expand_variables(template, var_data, extra_data = {})
          data = if var_data.class <= Hash
                   var_data.merge(extra_data)
                 else
                   resource_to_hash(var_data).merge(extra_data)
                 end
          extract_variables(template).each do |v|
            unless data.key?(v)
              raise "Missing variable :#{v} in #{data} on #{caller.join("\n")}}"
            end
            template.gsub!(/{{#{v}}}/, CGI.escape(data[v].to_s))
          end
          template
        end

        def expand_variables(template, var_data, extra_data = {})
          self.class.expand_variables(template, var_data, extra_data)
        end

        def fetch_resource(resource, self_link, kind)
          self.class.fetch_resource(resource, self_link, kind)
        end

        def async_op_url(data, extra_data = {})
          URI.join(
            'https://www.googleapis.com/compute/v1/',
            expand_variables(
              'projects/{{project}}/regions/{{region}}/operations/{{op_id}}',
              data, extra_data
            )
          )
        end

        def wait_for_operation(response, resource)
          op_result = return_if_object(response, 'compute#operation')
          return if op_result.nil?
          status = ::Google::HashUtils.navigate(op_result, %w[status])
          fetch_resource(
            resource,
            URI.parse(::Google::HashUtils.navigate(wait_for_completion(status,
                                                                       op_result,
                                                                       resource),
                                                   %w[targetLink])),
            'compute#disk'
          )
        end

        def wait_for_completion(status, op_result, resource)
          op_id = ::Google::HashUtils.navigate(op_result, %w[name])
          op_uri = async_op_url(resource, op_id: op_id)
          while status != 'DONE'
            debug("Waiting for completion of operation #{op_id}")
            raise_if_errors op_result, %w[error errors], 'message'
            sleep 1.0
            raise "Invalid result '#{status}' on gcompute_region_disk." \
              unless %w[PENDING RUNNING DONE].include?(status)
            op_result = fetch_resource(resource, op_uri, 'compute#operation')
            status = ::Google::HashUtils.navigate(op_result, %w[status])
          end
          op_result
        end

        def raise_if_errors(response, err_path, msg_field)
          self.class.raise_if_errors(response, err_path, msg_field)
        end

        def self.fetch_resource(resource, self_link, kind)
          get_request = ::Google::Compute::Network::Get.new(
            self_link, fetch_auth(resource)
          )
          return_if_object get_request.send, kind, true
        end

        def self.raise_if_errors(response, err_path, msg_field)
          errors = ::Google::HashUtils.navigate(response, err_path)
          raise_error(errors, msg_field) unless errors.nil?
        end

        def self.raise_error(errors, msg_field)
          raise IOError, ['Operation failed:',
                          errors.map { |e| e[msg_field] }.join(', ')].join(' ')
        end
      end
    end
  end
end

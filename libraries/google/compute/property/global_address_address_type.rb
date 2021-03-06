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
    module Property
      # A class to handle serialization of an enum with a
      # default.  The default is important because GCP sometimes
      # does not return the default value for an enum, but we need
      # to avoid detecting a diff if it is explicitly set.
      class AddressTypeEnum
        def self.coerce
          ->(x) { ::Google::Compute::Property::Enum.catalog_parse(x) }
        end

        def self.api_parse(value)
          return "EXTERNAL" if value.nil?
          value
        end

        def self.catalog_parse(value)
          value
        end
      end
    end
  end
end

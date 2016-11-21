# ------------------------------------------------------------------------------
# Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ------------------------------------------------------------------------------

# Manages WSO2 Complex Event Processor Deployment
class wso2cep (
  # wso2cep specific parameters - start
  $template_list             = $wso2cep::params::template_list,
  $is_datasource             = $wso2cep::params::is_datasource,
  $thrift_data_agent         = $wso2cep::params::thrift_data_agent,
  $binary_data_agent         = $wso2cep::params::binary_data_agent,
  $data_bridge               = $wso2cep::params::data_bridge,
  $single_node_deployment    = $wso2cep::params::single_node_deployment,
  $ha_deployment             = $wso2cep::params::ha_deployment,
  # wso2cep specific parameters - end

  # system configuration data
  $packages               = $wso2cep::params::packages,
  $file_list              = $wso2cep::params::file_list,
  $system_file_list       = $wso2cep::params::system_file_list,
  $directory_list         = $wso2cep::params::directory_list,
  $hosts_mapping          = $wso2cep::params::hosts_mapping,
  $java_home              = $wso2cep::params::java_home,
  $java_prefs_system_root = $wso2cep::params::java_prefs_system_root,
  $java_prefs_user_root   = $wso2cep::params::java_prefs_user_root,
  $master_datasources     = $wso2cep::params::master_datasources,
  $registry_mounts        = $wso2cep::params::registry_mounts,
  $carbon_home_symlink    = $wso2cep::params::carbon_home_symlink,
  $wso2_user              = $wso2cep::params::wso2_user,
  $wso2_group             = $wso2cep::params::wso2_group,
  $maintenance_mode       = $wso2cep::params::maintenance_mode,
  $install_mode           = $wso2cep::params::install_mode,
  $install_dir            = $wso2cep::params::install_dir,
  $pack_dir               = $wso2cep::params::pack_dir,
  $pack_filename          = $wso2cep::params::pack_filename,
  $pack_extracted_dir     = $wso2cep::params::pack_extracted_dir,
  $hostname               = $wso2cep::params::hostname,
  $mgt_hostname           = $wso2cep::params::mgt_hostname,
  $worker_node            = $wso2cep::params::worker_node,
  $patches_dir            = $wso2cep::params::patches_dir,
  $service_name           = $wso2cep::params::service_name,
  $service_template       = $wso2cep::params::service_template,
  $usermgt_datasource     = $wso2cep::params::usermgt_datasource,
  $local_reg_datasource   = $wso2cep::params::local_reg_datasource,
  $clustering             = $wso2cep::params::clustering,
  $dep_sync               = $wso2cep::params::dep_sync,
  $ports                  = $wso2cep::params::ports,
  $jvm                    = $wso2cep::params::jvm,
  $ipaddress              = $wso2cep::params::ipaddress,
  $fqdn                   = $wso2cep::params::fqdn,
  $sso_authentication     = $wso2cep::params::sso_authentication,
  $user_management        = $wso2cep::params::user_management,
  $enable_secure_vault    = $wso2cep::params::enable_secure_vault,
  $secure_vault_configs   = $wso2cep::params::secure_vault_configs,
  $key_stores             = $wso2cep::params::key_stores,

  $patch_list                = $wso2cep::params::patch_list,
  $platform_version          = $wso2cep::params::platform_version,
  $post_install_resources    = $wso2cep::params::post_install_resources,
  $post_configure_resources  = $wso2cep::params::post_configure_resources,
  $post_start_resources      = $wso2cep::params::post_start_resources,
  $cert_list                 = $wso2cep::params::cert_list
  # other paramaters - end

) inherits wso2cep::params {

  validate_string($is_datasource)
  validate_hash($single_node_deployment)
  validate_hash($ha_deployment)
  validate_hash($master_datasources)
  if $registry_mounts != undef {
    validate_hash($registry_mounts)
  }
  validate_string($hostname)
  validate_string($mgt_hostname)
  validate_bool($worker_node)
  validate_string($usermgt_datasource)
  validate_string($local_reg_datasource)
  validate_hash($clustering)
  validate_hash($dep_sync)
  validate_hash($ports)
  validate_hash($jvm)
  validate_string($fqdn)
  validate_hash($sso_authentication)
  validate_hash($user_management)

  class { '::wso2base':
    packages               => $packages,
    template_list          => $template_list,
    file_list              => $file_list,
    patch_list             => $patch_list,
    cert_list              => $cert_list,
    system_file_list       => $system_file_list,
    directory_list         => $directory_list,
    hosts_mapping          => $hosts_mapping,
    java_home              => $java_home,
    java_prefs_system_root => $java_prefs_system_root,
    java_prefs_user_root   => $java_prefs_user_root,
    vm_type                => $vm_type,
    wso2_user              => $wso2_user,
    wso2_group             => $wso2_group,
    product_name           => $product_name,
    product_version        => $product_version,
    platform_version       => $platform_version,
    carbon_home_symlink    => $carbon_home_symlink,
    remote_file_url        => $remote_file_url,
    maintenance_mode       => $maintenance_mode,
    install_mode           => $install_mode,
    install_dir            => $install_dir,
    pack_dir               => $pack_dir,
    pack_filename          => $pack_filename,
    pack_extracted_dir     => $pack_extracted_dir,
    patches_dir            => $patches_dir,
    service_name           => $service_name,
    service_template       => $service_template,
    ipaddress              => $ipaddress,
    enable_secure_vault    => $enable_secure_vault,
    secure_vault_configs   => $secure_vault_configs,
    key_stores             => $key_stores,
    carbon_home            => $carbon_home,
    pack_file_abs_path     => $pack_file_abs_path
  }

  if ($enable_secure_vault == true) {
    $key_store_password   = $secure_vault_configs['key_store_password']['password']
  }

  contain wso2base
  contain wso2base::system
  contain wso2base::clean
  contain wso2base::install
  contain wso2base::configure
  contain wso2base::service

  Class['::wso2base'] -> Class['::wso2base::system']
  -> Class['::wso2base::clean'] -> Class['::wso2base::install']
  -> Class['::wso2base::configure'] ~> Class['::wso2base::service']
}
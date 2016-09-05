#----------------------------------------------------------------------------
#  Copyright (c) 2016 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#----------------------------------------------------------------------------

class wso2cep::params {

  if($::use_hieradata == 'true')
  {
    $template_list            = hiera_array('wso2::template_list')
    $post_install_resources   = hiera('wso2::post_install_resources', { } )
    $post_configure_resources = hiera('wso2::post_configure_resources', { } )
    $post_start_resources     = hiera('wso2::post_start_resources', { } )
    $thrift_data_agent        = hiera('wso2::thrift_data_agent', { } )
    $binary_data_agent        = hiera('wso2::binary_data_agent', { } )
    $data_bridge              = hiera('wso2::data_bridge', { } )
    $single_node_deployment   = hiera('wso2::single_node_deployment', { } )
    $ha_deployment            = hiera('wso2::ha_deployment', { } )
  }
  else
  {
    $base_template_list = $wso2base::params::template_list
    $cep_template_list          = [
      'repository/conf/cep/storm/storm.yaml',
      'repository/conf/event-processor.xml',
      'repository/conf/data-bridge/data-agent-config.xml',
      'repository/conf/data-bridge/data-bridge-config.xml'
    ]

    $template_list = concat($base_template_list,$cep_template_list)

    $post_install_resources             = undef
    $post_configure_resources           = undef
    $post_start_resources               = undef
    $is_datasource                      = 'wso2_carbon_db'
    $platform_version                   = '4.4.0'
    $patch_list                         = []

    $thrift_data_agent     = {
      queueSize   => 100,
      batchSize   => 100,
      corePoolSize=> 100,
      maxPoolSize => 100,
    }

    $binary_data_agent ={
      queueSize    => 200,
      batchSize    => 200,
      corePoolSize => 200,
      maxPoolSize  => 200
    }

    $data_bridge ={
      workerThreads         => 2,
      maxEventBufferCapacity=> 2,
      eventBufferSize       => 2,
      clientTimeoutMin      => 20
    }

    $single_node_deployment ={
      enabled => true
    }

    $ha_deployment ={
      enabled          => false,
      presenter_enabled=> false,
      worker_enabled   => true,
      eventSync        =>{
        hostName => "${::ipaddress}",
        port     => 11224
      },
      management       =>{
        hostName=> "${::ipaddress}",
        port    => 10005
      },
      presentation     =>{
        hostName=> "${::ipaddress}",
        port    => 11002
      }
    }

  }
}
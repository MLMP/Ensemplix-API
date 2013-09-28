<?php

require_once "connection.php";
require_once "api.php";

class Core {

    private $args = array();
    private $action = "actionIndex";
    private $apiName;
    private $apiVersion;

    /** 
     * Парсинг параметров для выбора API, а так же передачи аргументов. 
     */
    public function __construct() {
        try {
            header('Access-Control-Allow-Origin: *');

            $this->args = explode('/', $_SERVER['REQUEST_URI']);
            $this->args = array_filter($this->args);
            $length = count($this->args);

            if($length == 0) {
                throw new ApiException("Please provide API version.");
            }

            foreach ($this->knownApiVersions() as $version) {
                if($this->args[1] == $version) {
                    $this->apiVersion = $this->args[1];
                }
            }

            if(isset($this->apiVersion)) {
                if($length == 2) {
                    $this->apiName = "api_" . strtolower($this->args[2]);
                }

                if($length >= 3) {
                    $this->apiName = "api_" . strtolower($this->args[2]);
                    $this->action = "action" . strtolower($this->args[3]);
                }
            } else {
                throw new ApiException("Please provide correct API version.");
            }

            $this->route();
        } catch (Exception $e) {
            echo $e->getMessage();
        }
    }

    /** 
     * Вызов API.
     */
    public function route() {
            $apiFile = "api/v" . $this->apiVersion . "/" . $this->apiName . ".php";
            if(file_exists($apiFile)) {
                include $apiFile;
                $api = new $this->apiName;
                $action = $this->action;
                $args = $this->args;

                if(method_exists($api, "actionCustom")) {
                    if(isset($args)) {
                        $api->actionCustom($args);
                    } else {
                        $api->actionCustom();
                    }
                } else if(method_exists($api, $action)) {
                    $this->args = array_slice($args, 3);

                    if(isset($this->args)) {
                        $api->$action($this->args);
                    } else {
                        $api->$action();
                    }
                } else {
                    throw new ApiException("Api not exists.");
                }
            } else {
                throw new ApiException("Api not exists.");
            }
    }

    /**
     * Версии API. 
     */
    public function knownApiVersions() {
        return array("1.0","2.0");
    }

}

new Core();

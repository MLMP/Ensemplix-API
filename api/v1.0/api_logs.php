<?php

class Api_Logs {

    private $searchMode = "all";
    private $world;
    private $player;
    private $limit = 200;
    private $from = 0;
    private $search;

    /** Доступ по паролю. */
    public function __construct() {
        if(isset($_POST['secret'])) {
            if($_POST['secret'] != "") {
                throw new ApiException("Access error.");
            }
        } else {
            throw new ApiException("Access error.");
        }
    }

    /** Логи команд и чата. */
    public function actionCustom($args) {
        if($args != null && count($args) > 1 && ($args[2] != "cmd" && $args[2] != "chat")) {
            $this->parseArgs($args);

            if(!isset($this->world) && !isset($this->player) && !isset($this->search)) {
                throw new ApiException("Please provide logs arguments.");
            }

            if(isset($this->player) && ($this->player == "ensiriuswOw" || $this->player == "ensiriusNyashka")) {
                throw new ApiException("You cant read this logs.");
            }

            $cnt = new Connection();
            $connection = $cnt->getLogsDatabaseConnection();

            if($this->searchMode == "all") {
                $query = "(SELECT * FROM chat WHERE";


                if(isset($this->world) && isset($this->player)) {
                    $query .= " LOWER(world) LIKE LOWER(:world) AND LOWER(player) = LOWER(:player)";
                } else if(isset($this->world)) {
                    $query .= " LOWER(world) LIKE LOWER(:world)";
                } else if(isset($this->player)) {
                    $query .= " LOWER(player) = LOWER(:player)";
                }

                if(isset($this->search)) {
                    $query .= " AND LOWER(chat) LIKE LOWER(:search)";
                }

                $query .= ") UNION (SELECT * FROM commands WHERE";

                if(isset($this->world) && isset($this->player)) {
                    $query .= " LOWER(world) LIKE LOWER(:world) AND LOWER(player) = LOWER(:player)";
                } else if(isset($this->world)) {
                    $query .= " LOWER(world) LIKE LOWER(:world)";
                } else if(isset($this->player)) {
                    $query .= " LOWER(player) = LOWER(:player)";
                }

                if(isset($this->search)) {
                    $query .= " AND LOWER(command) LIKE LOWER(:search)";
                }

                $query .= ")";

            } else {
                $query = "SELECT * FROM " . $this->searchMode . " WHERE ";

                if(isset($this->world) && isset($this->player)) {
                    $query .= "LOWER(world) LIKE LOWER(:world) AND LOWER(player) = LOWER(:player)";
                } else if(isset($this->world)) {
                    $query .= "LOWER(world) LIKE LOWER(:world)";
                } else if(isset($this->player)) {
                    $query .= "LOWER(player) = LOWER(:player)";
                }

                if(isset($this->search)) {
                    if($this->searchMode == "chat") {
                        $query .= " AND LOWER(chat) LIKE LOWER(:search)";
                    } else {
                        $query .= " AND LOWER(command) LIKE LOWER(:search)";
                    }
                }
            }

            if($this->searchMode == "all") {
                $query .= " ORDER BY time DESC LIMIT " . $this->limit . " OFFSET " . $this->from;
            } else {
                $query .= " ORDER BY time DESC LIMIT " . $this->limit . " OFFSET " . $this->from;
            }

            $statement = $connection->prepare($query);

            if(isset($this->world)) {
                $statement->bindParam(":world", $this->world);
            }

            if(isset($this->player)) {
                $statement->bindParam(":player", $this->player);
            }

            if(isset($this->search)) {
                $statement->bindParam(":search", $this->search);
            }

        } else {
            if(isset($_POST['search'])) {
                $this->search = "%" . $_POST['search'] . "%";
            }

            if(!isset($this->search)) {
                if(isset($args[2]) && $args[2] == "cmd") {
                    $query = "SELECT * FROM commands";
                } else if(isset($args[2]) && $args[2] == "chat") {
                    $query = "SELECT * FROM chat";
                } else {
                    $query = "(SELECT * FROM chat) UNION (SELECT * FROM commands)";
                }
            } else {
                if(isset($args[2]) && $args[2] == "cmd") {
                    $query = "SELECT * FROM commands WHERE LOWER(command) LIKE LOWER(:search)";
                } else if(isset($args[2]) && $args[2] == "chat") {
                    $query = "SELECT * FROM chat WHERE LOWER(chat) LIKE LOWER(:search)";
                } else {
                    $query = "(SELECT * FROM chat WHERE LOWER(chat) LIKE LOWER
                    (:search)) UNION (SELECT * FROM commands WHERE LOWER(command) LIKE LOWER(:search))";
                }
            }

            $query .= " ORDER BY time DESC LIMIT " . $this->limit . " OFFSET " . $this->from;

            $cnt = new Connection();
            $connection = $cnt->getLogsDatabaseConnection();
            $statement = $connection->prepare($query);

            if(isset($this->search)) {
                $statement->bindParam(":search", $this->search);
            }
        }

        $statement->execute();
        unset($connection);

        $output = array();
        while ($string = $statement->fetch(PDO::FETCH_ASSOC)) {
            if(!isset($string['chat']) && $string['chat'][0] != "/") {
                if($string['player'] != "ensiriuswOw" && $string['player'] != "ensiriusNyashka") {
                    $output[] = $string;
                }
            } else {
                /** Грязный фикс UNION. Колонка commands становится chat. Приходится парсить ее назад. */
                if($string['player'] != "ensiriuswOw" && $string['player'] != "ensiriusNyashka") {
                    $output2['player'] = $string['player'];
                    $output2['command'] = $string['chat'];
                    $output2['time'] = $string['time'];
                    $output2['world'] = $string['world'];
                    $output[] = $output2;
                }
            }
        }

        echo json_encode($output);
    }


    /** Парсер аргументов */
    private function parseArgs($args) {
        $world_key = array_search('world', $args);

        if(!empty($world_key)) {
            $this->world = "%" . $args[$world_key + 1] . "%";
        }

        $player_key = array_search('player', $args);

        if(!empty($player_key)) {
            $this->player = $args[$player_key + 1];
        }

        $limit_key = array_search('limit', $args);

        if(!empty($limit_key)) {
            $this->limit = (int)$args[$limit_key + 1];
            if(isset($args[$limit_key + 2])) {
                $this->from = (int)$args[$limit_key + 2];
            }

            if($this->limit > 200) {
                $this->limit = 200;
            }
        }

        $search_key = array_search('chat', $args);

        if(!empty($search_key)) {
            $this->searchMode = "chat";
        } else {
            $search_key = array_search('cmd', $args);

            if(!empty($search_key)) {
                $this->searchMode = "commands";
            }
        }

        if(isset($_POST['search'])) {
            $this->search = "%" . $_POST['search'] . "%";
        }
    }

}

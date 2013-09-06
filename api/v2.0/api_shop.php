<?php

class Api_shop {

    /**
     * GET /shop/info/
     *
     * История покупок и продаж в магазин у игрока.
     */
    public function actionInfo($args = null) {

        if($args != null) {
            $player = array_search('player', $args);

            if(isset($player)) {
                if(isset($args[$player + 1])) {
                    $player = $args[$player + 1];
                } else {
                    unset($player);
                }
            }

            $offset = array_search('offset', $args);

            if(isset($offset)) {
                if(isset($args[$offset + 1])) {
                    $offset = $args[$offset + 1];
                } else {
                    $offset = 0;
                }
            } else {
                $offset = 0;
            }

            $limit = array_search('limit', $args);

            if(isset($limit)) {
                if(isset($args[$limit + 1])) {
                    $limit = $args[$limit + 1];

                    if($limit < 5) {
                        $limit = 5;
                    } else if($limit > 100) {
                        $limit = 100;
                    }
                } else {
                    $limit = 100;
                }
            } else {
                $limit = 100;
            }

            $world = array_search('world', $args);

            if(isset($world)) {
                if(isset($args[$world + 1])) {
                    $world = $args[$world + 1];
                } else {
                    unset($world);
                }
            }

        } else {
            throw new ApiException("Please provide player.");
        }

        if(isset($player)) {

            $query = "SELECT `logs_shop`.*,IFNULL(`items`.`icon_item`,'Grid_не_найдено.png') AS `icon_item`
            FROM `logs_shop` LEFT JOIN `items` ON (`logs_shop`.`item` = `items`.`item`) WHERE (`logs_shop`.`from`
            = :player OR `logs_shop`.`to` = :player)";

            if(isset($world)) {
                $query .= " AND `world` LIKE LOWER(:world)";
            }

            $query .= " ORDER BY `id` DESC LIMIT " . $offset . "," . $limit;

            $connection = new Connection();
            $connection = $connection->getGameDatabaseConnection();

            try {
                $statement = $connection->prepare($query);
                $statement->bindParam(":player", $player);
                if(isset($world)) {
                    $statement->bindParam(":world", $world);
                }

                $statement->execute();
                unset($connection);

                $output = array();

                while ($string = $statement->fetch(PDO::FETCH_ASSOC)) {
                    $output[]['shop'] = $string;
                }

                echo json_encode($output);
            } catch (PDOException $e) {
                echo $e->getMessage();
            }
        } else {
            throw new ApiException("Please provide player.");
        }
    }
}

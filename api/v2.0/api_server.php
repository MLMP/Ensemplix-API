<?php

class Api_server {

    /** Версия лаунчера. */
    public function actionLauncher() {
        $connection = new Connection();
        $connection = $connection->getGameDatabaseConnection();

        try {
            $statement = $connection->prepare("SELECT `value` FROM `stats` WHERE `stat` = 'launcher_version' LIMIT 1");
            $statement->execute();

            $string = $statement->fetch(PDO::FETCH_ASSOC);

            $version = array("version" => $string['value']);

            echo json_encode($version);
            unset($connection);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    /** Версия сборки клиента. */
    public function actionClient() {
        $connection = new Connection();
        $connection = $connection->getGameDatabaseConnection();

        try {
            $statement = $connection->prepare("SELECT `value` FROM `stats` WHERE `stat` = 'client_version' LIMIT 1");
            $statement->execute();

            $string = $statement->fetch(PDO::FETCH_ASSOC);

            $version = array("version" => $string['value']);

            echo json_encode($version);
            unset($connection);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

}

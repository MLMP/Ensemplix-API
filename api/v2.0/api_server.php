<?php

class Api_server {

    /** Версия лаунчера. */
    public function actionLauncher() {
        $connection = new Connection();
        $connection = $connection->getGameDatabaseConnection();

        try {
            $statement = $connection->prepare("SELECT `value` FROM `stats` WHERE `stat` = 'launcher_version' LIMIT 1");
            $statement->execute();
            unset($connection);

            $string = $statement->fetch(PDO::FETCH_ASSOC);

            $version = array("version" => $string['value']);

            echo json_encode($version);
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
            unset($connection);

            $string = $statement->fetch(PDO::FETCH_ASSOC);

            $version = array("version" => $string['value']);

            echo json_encode($version);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    /** Информация о игровых серверах. Обновление информации о статусе и игроках происходит раз в минуту. */
    public function actionGame() {

        try {
            $connection = new Connection();
            $connection = $connection->getGameDatabaseConnection();

            $statement = $connection->prepare("SELECT * FROM `servers`");
            $statement->execute();
            unset($connection);

            $output = array();

            while ($string = $statement->fetch(PDO::FETCH_ASSOC)) {
                $output['server'][] = $string;
            }

            echo json_encode($output);
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

}

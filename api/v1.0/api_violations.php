<?php


class Api_Violations {

    /** 
     * GET /violations/
     *
     * Список наружений игрока. 
     */
    public function actionPlayer($args = null) {
        if($args == null) {
            throw new ApiException("Please provide player.");
        }

        $player = $args[0];

        $cnt = new Connection();
        $connection = $cnt->getLogsDatabaseConnection();

        $statement = $connection->prepare("SELECT * FROM violation WHERE player = ?");
        $statement->bindParam(1, $player);

        $statement->execute();
        unset($connection);
        $output = array();

        while ($string = $statement->fetch(PDO::FETCH_ASSOC)) {
            $output[] = $string;
        }

        if(count($output) > 0) {
            echo json_encode($output, JSON_UNESCAPED_UNICODE);
        } else {
            throw new ApiException("No violations found for " . $player);
        }
    }

}

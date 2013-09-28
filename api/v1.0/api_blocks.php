<?php


class Api_Blocks {

    private $x;
    private $y;
    private $z;

    private $world;

    public function actionPlace($args) {
        $this->blocks($args, true);
    }

    public function actionBreak($args) {
        $this->blocks($args, false);
    }

    /** 
     * История изменений блока на указанных координатах и мире. 
     */
    public function blocks($args, $status) {
        $this->parseArgs($args);

        if(!isset($this->x) || !isset($this->y) || !isset($this->z)) {
            throw new ApiException("Please provide coordinates.");
        }

        if(!isset($this->world)) {
            throw new ApiException("Please provide world.");
        }

        $location = $this->x . "," . $this->y . "," . $this->z;

        if($status) {
            $query = "SELECT * FROM blocks_placed WHERE location = ? AND world = ? ORDER BY time DESC LIMIT 15";
        } else {
            $query = "SELECT * FROM blocks_destroyed WHERE location = ? AND world = ? ORDER BY time DESC LIMIT 15";
        }

        $cnt = new Connection();
        $connection = $cnt->getLogsDatabaseConnection();

        $statement = $connection->prepare($query);
        $statement->bindParam(1, $location);
        $statement->bindParam(2, $this->world);

        $statement->execute();
        unset($connection);

        $output = array();
        while ($string = $statement->fetch(PDO::FETCH_ASSOC)) {
            $output[] = $string;
        }

        if(count($output) > 0) {
        echo json_encode($output);
        } else {
            throw new ApiException("No records found for " . $location . ", " . $this->world . ".");
        }
    }

    public function parseArgs($args) {
        $x = array_search('x', $args);

        if(isset($x)) {
            $this->x = $args[$x + 1];
        }

        $y = array_search('y', $args);

        if(isset($y)) {
            $this->y = $args[$y + 1];
        }

        $z = array_search('z', $args);

        if(isset($z)) {
            $this->z = $args[$z + 1];
        }

        $world = array_search('world', $args);

        if(!empty($world)) {
            $this->world = $args[$world + 1];
        }
    }



}

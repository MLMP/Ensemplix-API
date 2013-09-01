<?php

/** Exception который переобразует ошибку в JSON формат, что бы разработчики могли легко дебажить. */
Class ApiException extends Exception {

    public function __construct($error) {
        $this->message = json_encode(array("error" => $error));
    }

}
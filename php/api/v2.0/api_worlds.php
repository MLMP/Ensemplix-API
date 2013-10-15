<?php

class Api_worlds {

    /**
     * GET /worlds/
     *
     * Список миров. Название миров отличается от названия серверов и
     * может содержать дополнительные цифры или буквы. Данная версионасть
     * была необходима для удобства хранения данных о мирах, которые уже
     * не используются.
     */
    public function actionIndex() {
        $worlds = array(
            "Sandbox", "CarnageR4", "CogitoR4", "HiTech152", "Davids152", "Magnus152", "Theos", "DedalR2",
            "AmberR4"
        );

        echo json_encode($worlds);
    }

}

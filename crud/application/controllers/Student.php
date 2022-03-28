<?php
defined('BASEPATH') OR exit('No direct script access allowed');
header('Access-Control-Allow-Origin: *');

class Student extends CI_Controller {

	function __construct(){
        parent::__construct();      		
		$this->load->model('Student_model','student');
    }	
	
	
	public function event($action){
		switch($action) {
			case 'view' : 
				$this->student->view();
			break;
			case 'create': 
				$this->student->create();
			break;
			case 'edit': 
				$this->student->edit();
			break;
		}	
	}

    public function profile($id){
        $this->student->profile($id);
    }

    public function uploadimage(){

        define('UPLOAD_DIR','assets/profile/');

        $image_type=$image_type_aux[1];
        $image_base64=base64_decode($_POST['image']);
        $file= UPLOAD_DIR .$_POST['StudentID'].'.png';
        file_put_contents($file,$image_base64);
    
        $data = array(
            "Image" => $_POST['StudentID'].'.png'
        );

        $this->db->where("StudentID",$_POST['StudentID']);
        $this->db->update("student",$data);

}

public function login_validation_mobile(){
    $data = $this->student->login_validation_mobile();
    if ($data['result']!=FALSE) {
        echo json_encode($data['data']);
    }else{
        echo json_encode(false);
    }

}


	
}

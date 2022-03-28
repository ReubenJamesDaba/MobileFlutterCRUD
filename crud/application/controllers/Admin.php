<?php
defined('BASEPATH') OR exit('No direct script access allowed');
header('Access-Control-Allow-Origin: *');

class Admin extends CI_Controller {

	function __construct(){
        parent::__construct();      		
		$this->load->model('Admin_model','admin');
    }	
	
	
	public function event($action){
		switch($action) {
			case 'view' : 
				$this->admin->view();
			break;
			case 'create': 
				$this->admin->create();
			break;
			case 'edit': 
				$this->admin->edit();
			break;
		}	
	}

	
}

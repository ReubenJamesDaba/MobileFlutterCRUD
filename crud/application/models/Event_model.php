<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Event_model extends CI_Model {

    public function records(){
        $this->db->select("*");
        $this->db->from("event");
        $query = $this->db->get();
        return $query->result();
    }

    public function view(){       
        $row = $this->db->select("*")->order_by('EventID',"ASC")->get("event")->result();
        echo json_encode($row); 
    }   


	
}

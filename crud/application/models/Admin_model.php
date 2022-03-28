<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Admin_model extends CI_Model {

    public function records(){
        $this->db->select("*");
        $this->db->from("patient");
        $query = $this->db->get();
        return $query->result();
    }

    public function view(){       
        $row = $this->db->select("*")->order_by('StudentID',"ASC")->get("crud")->result();
        echo json_encode($row); 
    }   
    public function create(){       
        $res = $_POST;
        $data = array(
            'FirstName' => $res['FirstName'],
            'MiddleName' => $res['MiddleName'],
            'LastName' => $res['LastName'],
        ); 
        $this->db->insert('crud',$data);
        echo json_encode(true); 
    }   
    public function edit(){       
        $res = $_POST;
        $get = $_GET;
        $data = array(
            'FirstName' => $res['FirstName'],
            'MiddleName' => $res['MiddleName'],
            'LastName' => $res['LastName'],
        ); 
        $this->db->where('StudentID',$get['e']);
        $this->db->update('crud',$data);
        echo json_encode(true); 
    }   
    public function get(){       
        
        $get = $_GET;
        $this->db->select("*");
        $this->db->where("Student",$get['e']);
        $row = $this->db->get()->result();
        echo json_encode($row); 
        
    }   
    public function oxygen(){       
        $row = $this->db->select("*")->limit(5)->order_by('trackingID',"DESC")->get("patient")->result();
        
        echo json_encode($row); 
    }   
	
}

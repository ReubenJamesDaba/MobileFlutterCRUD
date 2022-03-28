<?php
defined('BASEPATH') OR exit('No direct script access allowed');
header('Access-Control-Allow-Origin: *');

class Event extends CI_Controller {

	function __construct(){
        parent::__construct();      		
		$this->load->model('Event_model','event');
    }	

    public function getevent($id){
        $query= $this->db->query("SELECT *,Event.EventID as Evn from joined 
        RIGHT JOIN event ON
         event.EventID = joined.EventID
        AND StudentID =$id")->result();
        
        
        echo json_encode($query);
    }

    public function create(){
        $res = $_POST;
        $data = array(
            'EventName' => $res["EventName"],
            'EventDetails' => $res["EventDetails"],
        );
        $this->db->insert("event",$data);
    }

    public function update(){
        $res = $_POST;
        $even = $res["EventID"];
        $stude = $res["StudentID"];
        $validate = $this->db->query("SELECT * from joined where StudentID = '$stude' AND EventID = '$even'")->num_rows();
        if($validate>=1){
            $this->db->where("EventID",$even);
            $this->db->where("StudentID",$stude);
            $this->db->delete("joined");
            $st = array("Status"=>1);
            $this->db->where("StudentID",$res["StudentID"]);
            $this->db->update("student",$st);
        }else{
            $data = array(
                'EventID' => $res["EventID"],
                'StudentID' => $res["StudentID"],
                'Status'    => 1
            );
            $this->db->insert("joined",$data);
            $st = array("Status"=>0);
            $this->db->where("StudentID",$res["StudentID"]);
            $this->db->update("student",$st);
        }
        
       
    }
    
	public function delete(){
        $res = $_POST;
        $even = $res["EventID"];
        
        $this->db->where("EventID",$even);
        $this->db->delete("event");

        $this->db->where("EventID",$even);
        $this->db->delete("joined");
    }	
}

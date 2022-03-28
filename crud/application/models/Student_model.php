<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Student_model extends CI_Model {

    public function records(){
        $this->db->select("*");
        $this->db->from("student");
        $query = $this->db->get();
        return $query->result();
    }

    public function view(){       
        $res = $_POST;
        $StudentID = $res['StudentID'];
        $row = $this->db->select("*")->where("StudentID",$StudentID)->order_by('StudentID',"ASC")->get("crud")->result();
        echo json_encode($row); 
    }   
    public function profile($id){       
        $StudentID = $id;
        $row = $this->db->select("*")->where("StudentID",$StudentID)->order_by('StudentID',"ASC")->get("student")->result();
        echo json_encode($row); 
    }   
    public function create(){       
        $res = $_POST;
        
        if($res){
            $student = $res['StudentID'];
            $id = $this->db->query("SELECT * from student where StudentID = '$student'")->num_rows();
            if($id>=1){
                echo json_encode(array("State"=>false)); 
            }else{
                $data2 = array(
                    'Password' => $res['Password'],
                    'StudentID' => $res['StudentID'],
                    'Status' => 1,
                ); 
                $this->db->insert('user',$data2);
    
                $data = array(
                    'FullName' => $res['FullName'],
                    'Contact' => $res['Contact'],
                    'StudentID' => $res['StudentID'],
                    'Status' => 1,
                ); 
                $this->db->insert('student',$data);
                echo json_encode(array("StudentID"=>$res['StudentID'] ,"State"=>true)); 
            }
            
        }else{
            echo json_encode(array("State"=>false)); 
        }
        
    }   

    public function login_validation_mobile(){
           
        $reg = $_POST['username'];
        $password = $_POST['password'];
        $result = $this->db->query("SELECT * from user where StudentID = '$reg' AND Password = '$password'");
        if($result->num_rows()>=1){
            return array('data'=>$result->result()[0],'result'=>true);
        }else{
            return false;
        }
    }
	
}

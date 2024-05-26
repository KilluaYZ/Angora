use libc;
use std::{self, env, mem, ops::{Deref, DerefMut}};
use std::mem::size_of;
use libc::setenv;
use crate::config;
use crate::shm::SHM;
use std::sync::Mutex;

// T must be fixed size
pub struct DFG_SHM {
    shm: SHM<[u32; config::MAX_DFG_MAP_SIZE]>
}

impl DFG_SHM {
    pub fn new() -> Self {
        let tmp_shm = SHM::<[u32; config::MAX_DFG_MAP_SIZE]>::new();
        env::set_var("SHM_ENV_VAR_DFG", tmp_shm.get_id().to_string());
        let mut tmp_ptr = unsafe { *tmp_shm.get_ptr() };
        for i in 0..config::MAX_DFG_MAP_SIZE{
            tmp_ptr[i] = 0;
        }
        DFG_SHM {
            shm: tmp_shm
        }
    }

    pub fn get_score(&self) -> u32{
        let mut score = 0;
        let ptr = unsafe { *self.shm.get_ptr() };
        for i in 0..config::MAX_DFG_MAP_SIZE{
            score = score + ptr[i];
        };
        score
    }

    pub fn from_id(id: i32) -> Self{
        let tmp_shm = SHM::<[u32; config::MAX_DFG_MAP_SIZE]>::from_id(id);
        DFG_SHM{
            shm: tmp_shm
        }
    }
}

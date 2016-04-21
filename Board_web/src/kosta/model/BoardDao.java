package kosta.model;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import kosta.mapper.BoardMapper;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class BoardDao {

	private static BoardDao dao = new BoardDao();
	
	public static BoardDao getInstance(){
		return dao;
	}
	
	public SqlSessionFactory getSqlSessionFactory(){
		
		String resource ="mybatis-config.xml";
		InputStream input =null;
		try {
			input = Resources.getResourceAsStream(resource);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new SqlSessionFactoryBuilder().build(input);
	}
	

	
	public int insertBoard(Board board){
		
		int re = -1;
		SqlSession sqlsession = getSqlSessionFactory().openSession();
		
		try {
			re = sqlsession.getMapper(BoardMapper.class).insertBoard(board);
			if(re  >0){
				sqlsession.commit();
			}else{
				sqlsession.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			sqlsession.close();
		}
		
		return re;
	}

	public List<Board> listBoard(int startRow,Search search) {
		SqlSession sqlSession = getSqlSessionFactory().openSession();
		
		return sqlSession.getMapper(BoardMapper.class).listBoard(new RowBounds(startRow, 2),search);
	}

	public Board selectBoard(int b_id) {
		SqlSession sqlSession = getSqlSessionFactory().openSession();
		return sqlSession.getMapper(BoardMapper.class).selectBoard(b_id);
	}
	public void updatehitBoard(int b_id){
		int re = -1;
		SqlSession sqlSession = getSqlSessionFactory().openSession();
		try {
			re = sqlSession.getMapper(BoardMapper.class).updatehitBoard(b_id);
			if(re  >0){
				sqlSession.commit();
			}else{
				sqlSession.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			sqlSession.close();
		}
	}
	public int updateBoardcontent(Board board){
		int re = -1;
		SqlSession sqlSession = getSqlSessionFactory().openSession();
		try {
			re = sqlSession.getMapper(BoardMapper.class).updateBoardcontent(board);
			if(re  >0){
				sqlSession.commit();
			}else{
				sqlSession.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			sqlSession.close();
		}
		return re;
	}

	public void updateStep(HashMap<String, Integer> map) {
		// TODO Auto-generated method stub
		int re = 0;
		SqlSession sqlSession = getSqlSessionFactory().openSession();
		try {
			re= sqlSession.getMapper(BoardMapper.class).updateStep(map);
			if(re >0){
				sqlSession.commit();
			}else{
				sqlSession.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			sqlSession.close();
		}
		
	}
	
	public int selectB_id(){
		SqlSession sqlSession = getSqlSessionFactory().openSession();
		if(sqlSession.getMapper(BoardMapper.class).selectB_id() == null){
			return 0;
		}else{
			return sqlSession.getMapper(BoardMapper.class).selectB_id();
		}
	}

	public int countBoard(Search search) {
		SqlSession sqlSession = getSqlSessionFactory().openSession();
		return sqlSession.getMapper(BoardMapper.class).countBoard(search);
	}

	public List<Reply> replyList(int b_id) {
		SqlSession sqlSession = getSqlSessionFactory().openSession();
		return sqlSession.getMapper(BoardMapper.class).replyList(b_id);
	}

	public int insertReply(Reply reply) {
		int re = -1;
		SqlSession sqlsession = getSqlSessionFactory().openSession();
		
		try {
			re = sqlsession.getMapper(BoardMapper.class).insertReply(reply);
			if(re  >0){
				sqlsession.commit();
			}else{
				sqlsession.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			sqlsession.close();
		}
		
		return re;
	}
}

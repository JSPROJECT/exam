package kosta.model;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardService {
	
	public static BoardDao dao;
	
	public static BoardService service = new BoardService();
	
	private static final int PAGE_SIZE = 2;
	
	public static BoardService getInstance(){
		dao = BoardDao.getInstance();
		return service;
	}
	
	public int insertBoardService(HttpServletRequest request) throws IOException{
		
		Board board = new Board();
		String uploadPath = request.getRealPath("upload");
		int size = 20 * 1024 * 1024; // 20MB
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
		board.setB_name(multi.getParameter("b_name"));
		board.setB_title(multi.getParameter("b_title"));
		board.setB_content(multi.getParameter("b_content"));
		board.setB_pwd(multi.getParameter("b_pwd"));
		
		board.setB_id(Integer.parseInt(multi.getParameter("b_id")));
		board.setB_ref(Integer.parseInt(multi.getParameter("b_ref")));
		board.setB_step(Integer.parseInt(multi.getParameter("b_step")));
		board.setB_level(Integer.parseInt(multi.getParameter("b_level")));
		
		//파일업로드
		if(multi.getFilesystemName("b_fname") != null){
			String b_fname = multi.getFilesystemName("b_fname");
			board.setB_fname(b_fname); 
			
			//섬네일 이미지(jps,gif,png)
			String pattern = b_fname.substring(b_fname.lastIndexOf(".")+1);
			String headName = b_fname.substring(0, b_fname.lastIndexOf("."));
			
			//원본 파일이미지 => 객체화
			String imagePath = uploadPath+"\\"+b_fname;
			File src = new File(imagePath);
			
			//썸네일 이미지 => 객체화
			String thumImagePath = uploadPath +"\\"+headName+"_small."+pattern;
			File dest = new File(thumImagePath);
			
			ImageUtil util = new ImageUtil();
			
			//썸네일 이미지 생성
			if(pattern.equals("jpg")||pattern.equals("gif")){
				util.resize(src, dest, 100, ImageUtil.RATIO);
			}
			
			
			
		}else{
			board.setB_fname("");
		}
		
		
		//답변글일때
		if(board.getB_id() !=0){
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("b_step", board.getB_step());
			map.put("b_ref", board.getB_ref());
			
			dao.updateStep(map);
			
			board.setB_id(dao.selectB_id()+1);
			board.setB_step(board.getB_step()+1);
			board.setB_level(board.getB_level()+1);
			
		}else{//원본글
			board.setB_id(dao.selectB_id()+1);
			board.setB_ref(dao.selectB_id()+1);
		}
		
		
		return dao.insertBoard(board);
	}
	
	public ListModel listBoardService(int requestPage,HttpServletRequest request){
		
		Search search = new Search();
		HttpSession session = request.getSession();
		
		//기존의 검색된 세션내용을 삭제 해주셈
		if(request.getParameter("temp") != null){
			session.removeAttribute("search");
		}
		
		//검색시
		if(request.getParameterValues("area")!=null){
			search.setArea(request.getParameterValues("area"));
			search.setSearchKey("%"+request.getParameter("searchKey")+"%");
			session.setAttribute("search", search);
		//검색후 페이징을 클릭했을때
		}else if((Search)session.getAttribute("search") !=null){
			search = (Search)session.getAttribute("search");
		}
	
		
		//페이징초리~ 페이지당 글갯수, 현재페이지, 총글갯수, 총페이지수
		//해당하는~! startPage, endPage
		int totalCount = dao.countBoard(search);
		int totalPageCount = totalCount/PAGE_SIZE;
		if(totalCount%PAGE_SIZE>0){
			totalPageCount++;
		}
		
		int startPage = requestPage -( requestPage -1 )% 5;
		int endPage = startPage +4;
		
		if (endPage > totalPageCount) {
			endPage = totalPageCount;
		}
		
		List<Board> list = dao.listBoard((requestPage-1)*PAGE_SIZE,search);
		
		return  new ListModel(list, requestPage, totalPageCount, startPage, endPage);	
	}
	
	public Board selectBoardService(int b_id){
		dao.updatehitBoard(b_id);
		return dao.selectBoard(b_id);
	}
	public Board updatebeforeService(int b_id){
		return dao.selectBoard(b_id);
	}
	public int updateBoardService(Board board){
		Board board2 = dao.selectBoard(board.getB_id());
		if(board2.getB_pwd().equals(board.getB_pwd())){
			return dao.updateBoardcontent(board);
		}else{
			return -1;
		}
	}
	
	public List<Reply> listreply(int b_id){
		return dao.replyList(b_id);
	}
	
	public int insertReply(Reply reply){
		return dao.insertReply(reply);
	}
	
	public int deleteReply(String r_id){
		
		return 0;
	}
	
}
